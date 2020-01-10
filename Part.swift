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

public struct BeforeAll: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {
        closure()
    }
}

public struct AfterAll: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {
        closure()
    }
}

public struct BeforeEach: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {
        closure()
    }
}

public struct AfterEach: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {
        closure()
    }
}

public struct Describe: Part {
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

    public func run() throws {
        try parts.filter({ $0 is BeforeAll }).forEach({ try $0.run() })

        try parts.filter({ $0 is It }).forEach({ it in
            try parts.filter({ $0 is BeforeEach }).forEach({ try $0.run() })
            try it.run()
            try parts.filter({ $0 is AfterEach }).forEach({ try $0.run() })
        })

        try parts.filter({ $0 is Describe }).forEach({ it in
            try parts.filter({ $0 is BeforeEach }).forEach({ try $0.run() })
            try it.run()
            try parts.filter({ $0 is AfterEach }).forEach({ try $0.run() })
        })

        try parts.filter({ $0 is AfterAll }).forEach({ try $0.run() })
    }
}

public struct It: Part {
    let name: String
    let closure: () -> Void

    public init(_ name: String, closure: @escaping () -> Void) {
        self.name = name
        self.closure = closure
    }

    public func run() throws {
        closure()
    }
}
