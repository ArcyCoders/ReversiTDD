//
//  Enums.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum Player
{
    case black
    case white

    func next() -> Player
    {
        return (self == .black) ? .white : .black
    }
}

struct DirectionType
{
    typealias Direction = (vx: Int, vy: Int)

    static let leftUp: Direction = (vx: -1, vy: -1)
    static let up: Direction = (vx: 0, vy: -1)
    static let rightUp: Direction = (vx: 1, vy: -1)
    static let left: Direction = (vx: -1, vy: 0)
    static let right: Direction = (vx: 1, vy: 0)
    static let leftDown: Direction = (vx: -1, vy: 1)
    static let down: Direction = (vx: 0, vy: 1)
    static let rightDown: Direction = (vx: 1, vy: 1)

    static func all() -> [Direction]
    {
        return [
            DirectionType.leftUp,
            DirectionType.up,
            DirectionType.rightUp,
            DirectionType.left,
            DirectionType.right,
            DirectionType.leftDown,
            DirectionType.down,
            DirectionType.rightDown
        ]
    }
}
