//
//  Board.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum Column: Int, Comparable {
    case a, b, c, d, e, f, g, h

    func nextColumn(inDirection direction: HorizontalDirection) -> Column? {
        var nextColumnOffset = 0

        if direction == .left {
            nextColumnOffset = -1
        }
        else if direction == .right {
            nextColumnOffset = 1
        }

        return Column(rawValue: self.rawValue + nextColumnOffset)
    }

    static func getValues() -> [Column] {
        return [.a, .b, .c, .d, .e, .f, .g, .h]
    }
}

enum Row: Int, Comparable {
    case _1, _2, _3, _4, _5, _6, _7, _8

    func nextRow(inDirection direction: VerticalDirection) -> Row? {
        var nextRowOffset = 0

        if direction == .up {
            nextRowOffset = -1
        }
        else if direction == .down {
            nextRowOffset = 1
        }

        return Row(rawValue: self.rawValue + nextRowOffset)
    }

    static func getValues() -> [Row] {
        return [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8]
    }
}

class Board: Equatable {
    var taken: [Field]

    var takenFieldsCount: Int {
        return taken.count
    }

    init(taken: [Field] = []) {
        self.taken = taken
    }

    func add(field: Field) {
        taken.append(field)
    }

    func getField(column: Column, row: Row) -> Field? {
        return taken.filter { $0.row == row && $0.column == column }.first
    }

    func getNextFieldInDirection(fromPreviousField previousField: Field, direction: Direction) -> Field? {
        guard let nextRow = previousField.row.nextRow(inDirection: direction.vertical) else { return nil }
        guard let nextColumn = previousField.column.nextColumn(inDirection: direction.horizontal) else { return nil }

        return getField(column: nextColumn, row: nextRow)
    }

    func clear() {
        taken.removeAll()
    }

    static func ==(lhs: Board, rhs: Board) -> Bool {
        return lhs.taken == rhs.taken
    }
}
