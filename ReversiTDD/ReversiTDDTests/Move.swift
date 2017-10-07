//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Move: Equatable {
    let point: Point
    let takenBy: Player?

    init(x: Horizontal, y: Vertical, takenBy: Player) {
        self.point = Point(x: x, y: y)
        self.takenBy = takenBy
    }

    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.point == rhs.point && lhs.takenBy == rhs.takenBy
    }
}

