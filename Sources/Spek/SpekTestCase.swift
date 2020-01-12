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
    open class func makeDescribe() -> Describe {
        return Describe("empty")
    }

    #if canImport(SpekHelper)

    override public class func spekGenerateTestMethodNames() -> [String] {
        let describe = Self.makeDescribe()

        var names: [String] = []
        generate(describe: describe, names: &names)
        return names
    }

    private static func addInstanceMethod(name: String, closure: @escaping () -> Void) -> String {
        let block: @convention(block) (SpekTestCase) -> Void = { spekTestCase in
            let _ = spekTestCase
            closure()
        }

        let implementation = imp_implementationWithBlock(block as Any)
        let selector = NSSelectorFromString(name)
        class_addMethod(self, selector, implementation, "v@:")

        return name
    }

    private static func generate(describe: Describe, prefixes: [String] = [], names: inout [String]) {
        for part in describe.parts {
            switch part {
            case let it as It:
                let closure = {
                    do {
                        let parts = describe.parts
                        try parts.filter({ $0 is BeforeAll }).forEach({ try $0.run() })
                        try parts.filter({ $0 is BeforeEach }).forEach({ try $0.run() })

                        try it.run()

                        try parts.filter({ $0 is AfterEach }).forEach({ try $0.run() })
                        try parts.filter({ $0 is AfterAll }).forEach({ try $0.run() })
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }

                names.append(
                    addInstanceMethod(
                        name: makeName(prefixes: prefixes, describeName: describe.name, itName: it.name),
                        closure: closure
                    )
                )
            case let nestedDescribe as Describe:
                generate(describe: nestedDescribe, prefixes: prefixes + [describe.name], names: &names)
            case let sub as Sub:
                generate(describe: sub.closure(), prefixes: prefixes + [describe.name], names: &names)
            default:
                break
            }
        }
    }

    private static func makeName(prefixes: [String], describeName: String, itName: String) -> String {
        var strings: [String] = [
            "test"
        ]

        strings.append(contentsOf: prefixes)
        strings.append(contentsOf: [
            describeName,
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
