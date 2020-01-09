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

    }
}

public struct AfterAll: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {

    }
}

public struct BeforeEach: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {

    }
}

public struct AfterEach: Part {
    let closure: () -> Void

    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    public func run() throws {

    }
}

public struct Describe: Part {
    let name: String
    let parts: [Part]

    public init(name: String, @PartBuilder builder: () -> [Part]) {
        self.name = name
        self.parts = builder()
    }

    public init(name: String, @PartBuilder builder: () -> Part) {
        self.name = name
        self.parts = [builder()]
    }

    public func run() throws {

    }
}

public struct It: Part {
    let name: String
    let closure: () -> Void

    public init(name: String, closure: @escaping () -> Void) {
        self.name = name
        self.closure = closure
    }

    public func run() throws {

    }
}
