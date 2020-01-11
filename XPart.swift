//
//  XPart.swift
//  Spek
//
//  Created by khoa on 10/01/2020.
//

import Foundation

public struct XBeforeAll: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }
}

public struct XAfterAll: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }
}

public struct XBeforeEach: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }
}

public struct XAfterEach: Part {
    let closure: () throws -> Void

    public init(closure: @escaping () throws -> Void) {
        self.closure = closure
    }
}

public struct XDescribe: Part {
    let name: String
    let parts: [Part]

    public init(_ name: String, @PartBuilder builder: () -> [Part]) {
        self.name = name
        self.parts = builder()
    }

    public init(_ name: String, @PartBuilder builder: () -> Part) {
        self.name = name
        self.parts = [builder()]
    }
}

public struct XIt: Part {
    let name: String
    let closure: () throws -> Void

    public init(_ name: String, closure: @escaping () throws -> Void) {
        self.name = name
        self.closure = closure
    }
}

public struct XSub: Part {
    let closure: () -> Describe
    public init(closure: @escaping () -> Describe) {
        self.closure = closure
    }
}

public typealias XContext = XDescribe
