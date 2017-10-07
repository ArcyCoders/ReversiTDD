//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum Player: Int, CustomStringConvertible {
    case White
    case Black

    func other() -> Player {
        if case .White = self {
            return .Black
        } else {
            return .White
        }
    }

    var description: String {
        switch self {
        case .White:
            return "White"
        case .Black:
            return "Black"
        }
    }
}
