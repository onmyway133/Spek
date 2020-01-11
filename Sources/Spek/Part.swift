//
//  Spek
//
//  Created by khoa on 00/01/2020.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

@_functionBuilder
public struct PartBuilder {
    public static func buildBlock(_ parts: Part...) -> [Part] {
        parts
    }
}

public protocol Part {
    func run() throws
}

public extension Part {
    func run() throws {}
}

public struct BeforeAll: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }

    public func run() throws {
        try closure()
    }
}

public struct AfterAll: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }

    public func run() throws {
        try closure()
    }
}

public struct BeforeEach: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }

    public func run() throws {
        try closure()
    }
}

public struct AfterEach: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }

    public func run() throws {
        try closure()
    }
}

public struct Describe: Part {
    let name: String
    let parts: [Part]

    public init(_ name: String, parts: [Part] = []) {
        self.name = name
        self.parts = parts
    }

    public init(_ name: String, @PartBuilder builder: () -> [Part]) {
        self.init(name, parts: builder())
    }

    public init(_ name: String, @PartBuilder builder: () -> Part) {
        self.init(name, parts: [builder()])
    }

    public func run() throws {
        try parts.filter({ $0 is BeforeAll }).forEach({ try $0.run() })

        try parts.forEach { part in
            try parts.filter({ $0 is BeforeEach }).forEach({ try $0.run() })

            switch part {
            case is It, is Describe, is Sub:
                try part.run()
            default:
                break
            }

            try parts.filter({ $0 is AfterEach }).forEach({ try $0.run() })
        }

        try parts.filter({ $0 is AfterAll }).forEach({ try $0.run() })
    }
}

public struct It: Part {
    let name: String
    let closure: () throws -> Void

    public init(_ name: String, closure: @escaping () throws -> Void) {
        self.name = name
        self.closure = closure
    }

    public func run() throws {
        try closure()
    }
}

public struct Sub: Part {
    let closure: () -> Describe
    public init(closure: @escaping () -> Describe) {
        self.closure = closure
    }

    public func run() throws {
        try closure().run()
    }
}

public typealias Context = Describe
