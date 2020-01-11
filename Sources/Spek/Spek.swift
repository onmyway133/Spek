//
//  Spek
//
//  Created by khoa on 00/01/2020.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import Foundation
import XCTest

public func spec(@PartBuilder builder: () -> [Part]) {
    run(parts: builder())
}

public func spec(@PartBuilder builder: () -> Part) {
    run(parts: [builder()])
}

private func run(parts: [Part]) {
    do {
        try parts.forEach {
            try $0.run()
        }
    } catch {
        XCTFail(error.localizedDescription)
    }
}
