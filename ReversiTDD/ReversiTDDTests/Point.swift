//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum Vertical: Int {
    case _1, _2, _3, _4, _5, _6, _7, _8
}

enum Horizontal: Int {
    case a, b, c, d, e, f, g, h
}

enum Shift {
    case right, left, top, bottom, topLeft, topRight, bottomLeft, bottomRight
}

struct Point: Equatable {
    let x: Horizontal
    let y: Vertical

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func shifted(to shift: Shift) -> Point? {
        let x: Horizontal?
        let y: Vertical?
        switch shift {
        case .right:
            x = Horizontal(rawValue: self.x.rawValue + 1)
            y = self.y
        case .left:
            x = Horizontal(rawValue: self.x.rawValue - 1)
            y = self.y
        case .top:
            x = self.x
            y = Vertical(rawValue: self.y.rawValue + 1)
        case .bottom:
            x = self.x
            y = Vertical(rawValue: self.y.rawValue - 1)
        case .topLeft:
            x = Horizontal(rawValue: self.x.rawValue - 1)
            y = Vertical(rawValue: self.y.rawValue + 1)
        case .topRight:
            x = Horizontal(rawValue: self.x.rawValue + 1)
            y = Vertical(rawValue: self.y.rawValue + 1)
        case .bottomLeft:
            x = Horizontal(rawValue: self.x.rawValue - 1)
            y = Vertical(rawValue: self.y.rawValue - 1)
        case .bottomRight:
            x = Horizontal(rawValue: self.x.rawValue + 1)
            y = Vertical(rawValue: self.y.rawValue - 1)
        }

        if let x = x, let y = y {
            return Point(x: x, y: y)
        } else {
            return nil
        }
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return "Point(x: \(x), y: \(y))"
    }
}

