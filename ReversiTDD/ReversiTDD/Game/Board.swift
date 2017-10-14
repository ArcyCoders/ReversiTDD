//
//  Board.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public enum Column: Int, Comparable {
    case a, b, c, d, e, f, g, h

    public func nextColumn(inDirection direction: HorizontalDirection) -> Column? {
        return Column(rawValue: self.rawValue + direction.rawValue)
    }

    public static func getValues() -> [Column] {
        return [.a, .b, .c, .d, .e, .f, .g, .h]
    }
}

public enum Row: Int, Comparable {
    case _1, _2, _3, _4, _5, _6, _7, _8

    public func nextRow(inDirection direction: VerticalDirection) -> Row? {
        return Row(rawValue: self.rawValue + direction.rawValue)
    }

    public static func getValues() -> [Row] {
        return [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8]
    }
}

public struct Direction: Equatable {
    public let vertical: VerticalDirection
    public let horizontal: HorizontalDirection

    public static let none: Direction = Direction(vertical: .none, horizontal: .none)

    public static func getValues() -> [Direction] {
        var directions: [Direction] = []

        for verticalDirection in VerticalDirection.getValues() {
            for horizontalDirection in HorizontalDirection.getValues() {
                directions.append(Direction(vertical: verticalDirection, horizontal: horizontalDirection))
            }
        }

        return directions.filter { $0 != Direction.none }
    }

    public static func ==(lhs: Direction, rhs: Direction) -> Bool {
        return lhs.vertical == rhs.vertical
                && lhs.horizontal == rhs.horizontal
    }
}

public enum VerticalDirection: Int {
    case up = -1
    case down = 1
    case none = 0

    public static func getValues() -> [VerticalDirection] {
        return [.up, .down, .none]
    }
}

public enum HorizontalDirection: Int {
    case left = -1
    case right = 1
    case none = 0

    static func getValues() -> [HorizontalDirection] {
        return [.left, .right, .none]
    }
}

public func < <T: RawRepresentable>(a: T, b: T) -> Bool where T.RawValue: Comparable {
    return a.rawValue < b.rawValue
}

public class Board: Equatable {
    private var taken: [Field]

    public var takenFieldsCount: Int {
        return taken.count
    }

    public init(taken: [Field] = []) {
        self.taken = taken
    }

    public func add(field: Field) {
        taken.append(field)
    }

    public func getField(column: Column, row: Row) -> Field? {
        return taken.filter { $0.row == row && $0.column == column }.first
    }

    public func getNumberOfFieldsTaken(ofColor color: Disk.Color? = nil) -> Int {
        if let color = color {
            return taken.filter { $0.disk?.currentColor == color }.count
        }

        return taken.count
    }

    public func getNextFieldInDirection(fromPreviousField previousField: Field, direction: Direction) -> Field? {
        guard let nextRow = previousField.row.nextRow(inDirection: direction.vertical) else { return nil }
        guard let nextColumn = previousField.column.nextColumn(inDirection: direction.horizontal) else { return nil }

        return getField(column: nextColumn, row: nextRow)
    }

    public func getAllFields(containingDiskWithColor diskColor: Disk.Color?) -> [Field] {
        return taken.filter { $0.disk?.currentColor == diskColor }
    }

    public func getNeighbouringFields(forField field: Field) -> [Field] {
        return Direction.getValues().flatMap { getNextFieldInDirection(fromPreviousField: field, direction: $0) }
    }

    public func clear() {
        taken.removeAll()
    }

    public static func ==(lhs: Board, rhs: Board) -> Bool {
        return lhs.taken == rhs.taken
    }
}
