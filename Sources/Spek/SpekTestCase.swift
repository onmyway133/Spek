//
//  SpekTestCase.swift
//  Spek
//
//  Created by khoa on 11/01/2020.
//

#if canImport(XCTest)

import XCTest

#if canImport(SpekHelper)
import SpekHelper
#else
public typealias SpekHelperTestCase = XCTestCase
#endif

open class SpekTestCase: SpekHelperTestCase {
    open class func describe() -> Describe {
        return Describe("empty")
    }

    #if canImport(SpekHelper)

    override public class func spekGenerateTestMethodNames() -> [String] {
        let describe = Self.describe()

        var methods: [Method] = []
        generate(
            describe: describe,
            accumulation: Accumulation(),
            methods: &methods
        )

        methods.forEach { method in
            addInstanceMethod(name: method.name, closure: method.closure)
        }

        return methods.map({ $0.name })
    }

    // MARK: -  Private

    private struct Method {
        let name: String
        let closure: () -> Void
    }

    private struct Accumulation {
        var before: () throws -> Void = {}
        var after: () throws -> Void = {}
        var prefix: [String] = []
    }

    private static func addInstanceMethod(name: String, closure: @escaping () -> Void) {
        let block: @convention(block) (SpekTestCase) -> Void = { spekTestCase in
            let _ = spekTestCase
            closure()
        }

        let implementation = imp_implementationWithBlock(block as Any)
        let selector = NSSelectorFromString(name)
        class_addMethod(self, selector, implementation, "v@:")
    }

    private static func generate(
        describe: Describe,
        accumulation: Accumulation,
        methods: inout [Method]
    ) {

        let accumulation = update(
            accumulation: accumulation,
            describe: describe
        )

        for part in describe.parts {
            switch part {
            case let it as It:
                let closure = {
                    do {
                        try accumulation.before()
                        try it.run()
                        try accumulation.after()
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }

                methods.append(
                    Method(
                        name: makeName(
                            prefix: accumulation.prefix,
                            itName: it.name
                        ),
                        closure: closure
                    )
                )
            case let nestedDescribe as Describe:
                generate(describe: nestedDescribe, accumulation: accumulation, methods: &methods)
            case let sub as Sub:
                let nestedDescribe = sub.closure()
                generate(describe: nestedDescribe, accumulation: accumulation, methods: &methods)
            default:
                break
            }
        }
    }

    private static func update(
        accumulation: Accumulation,
        describe: Describe
    ) -> Accumulation {
        var updatedAccumulation = accumulation
        updatedAccumulation.before = {
            try accumulation.before()
            try describe.runBefore()
        }

        updatedAccumulation.after = {
            try describe.runAfter()
            try accumulation.after()
        }

        updatedAccumulation.prefix = accumulation.prefix + [describe.name]
        return updatedAccumulation
    }

    private static func makeName(prefix: [String], itName: String) -> String {
        var strings: [String] = [
            "test"
        ]

        strings.append(contentsOf: prefix)
        strings.append(contentsOf: [
            itName
        ])

        return normalize(strings)
    }

    private static func normalize(_ strings: [String]) -> String {
        return strings
            .map({ $0.filter({ $0.isASCII }) })
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .map({ $0.replacingOccurrences(of: " ", with: "_") })
            .joined(separator: "_")
            .replacingOccurrences(of: "__", with: "_")
    }

    #endif
}

#endif

private extension Describe {
    func runBefore() throws {
        try parts.filter({ $0 is BeforeAll }).forEach({ try $0.run() })
        try parts.filter({ $0 is BeforeEach }).forEach({ try $0.run() })
    }

    func runAfter() throws {
        try parts.filter({ $0 is AfterEach }).forEach({ try $0.run() })
        try parts.filter({ $0 is AfterAll }).forEach({ try $0.run() })
    }
}
