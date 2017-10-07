//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Move: Equatable {
    let point: Point
    let takenBy: Player?

    init(point: Point, takenBy: Player) {
        self.point = point
        self.takenBy = takenBy
    }

    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.point == rhs.point && lhs.takenBy == rhs.takenBy
    }
}

