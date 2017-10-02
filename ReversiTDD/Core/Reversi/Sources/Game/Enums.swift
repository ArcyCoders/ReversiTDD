//
//  Enums.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public enum Player
{
    case black
    case white

    public func next() -> Player
    {
        return (self == .black) ? .white : .black
    }
}

public struct DirectionType
{
    public typealias Direction = (vx: Int, vy: Int)

    public static let leftUp: Direction = (vx: -1, vy: -1)
    public static let up: Direction = (vx: 0, vy: -1)
    public static let rightUp: Direction = (vx: 1, vy: -1)
    public static let left: Direction = (vx: -1, vy: 0)
    public static let right: Direction = (vx: 1, vy: 0)
    public static let leftDown: Direction = (vx: -1, vy: 1)
    public static let down: Direction = (vx: 0, vy: 1)
    public static let rightDown: Direction = (vx: 1, vy: 1)

    public static func all() -> [Direction]
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
