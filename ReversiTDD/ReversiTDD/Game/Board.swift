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
        var nextColumnOffset = 0

        if direction == .left {
            nextColumnOffset = -1
        }
        else if direction == .right {
            nextColumnOffset = 1
        }

        return Column(rawValue: self.rawValue + nextColumnOffset)
    }

    public static func getValues() -> [Column] {
        return [.a, .b, .c, .d, .e, .f, .g, .h]
    }
}

public enum Row: Int, Comparable {
    case _1, _2, _3, _4, _5, _6, _7, _8

    public func nextRow(inDirection direction: VerticalDirection) -> Row? {
        var nextRowOffset = 0

        if direction == .up {
            nextRowOffset = -1
        }
        else if direction == .down {
            nextRowOffset = 1
        }

        return Row(rawValue: self.rawValue + nextRowOffset)
    }

    public static func getValues() -> [Row] {
        return [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8]
    }
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

    public func clear() {
        taken.removeAll()
    }

    public static func ==(lhs: Board, rhs: Board) -> Bool {
        return lhs.taken == rhs.taken
    }
}
