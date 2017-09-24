//
//  ReversiSpec.swift
//  ReversiTDD
//
//  Based on:
//  1. https://en.wikipedia.org/wiki/Reversi
//  2. http://www.hannu.se/games/othello/rules.htm
//
//  Created by Krzysztof Moczała on 03/09/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble

// TODO: - handle move error

enum Column: Int, Comparable {
    case a, b, c, d, e, f, g, h

    func nextColumn(inDirection direction: Direction) -> Column? {
        var nextColumnOffset = 0

        if direction == .left {
            nextColumnOffset = -1
        }

        return Column(rawValue: self.rawValue + nextColumnOffset)
    }

    static func getValues() -> [Column] {
        return [.a, .b, .c, .d, .e, .f, .g, .h]
    }
}

enum Row: Int, Comparable {
    case _1, _2, _3, _4, _5, _6, _7, _8

    func nextRow(inDirection direction: Direction) -> Row? {
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

enum Direction {
    case up
    case down
    case left

    static func getValues() -> [Direction] {
        return [.up, .down, .left]
    }
}

func <<T: RawRepresentable>(a: T, b: T) -> Bool where T.RawValue: Comparable {
    return a.rawValue < b.rawValue
}

enum Disk: Int {
    case white, black
}

class Field: Equatable, Hashable {
    let column: Column
    let row: Row
    var disk: Disk?

    public init(column: Column, row: Row, disk: Disk) {
        self.column = column
        self.row = row
        self.disk = disk
    }

    // TODO: handle no disk
    func flipDisk() {
        if let diskToFlip = disk {
            disk = diskToFlip == .black ? .white : .black
        }
    }

    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column && lhs.disk == rhs.disk
    }

    public var hashValue: Int {
        let diskValue = disk?.rawValue ?? 0

        return "\(row)\(column)disk:\(diskValue)".hashValue
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

    func getNextFieldInDirection(previousField: Field, direction: Direction) -> Field? {
        guard let nextRow = previousField.row.nextRow(inDirection: direction) else { return nil }
        guard let nextColumn = previousField.column.nextColumn(inDirection: direction) else { return nil }

        return getField(column: nextColumn, row: nextRow)
    }

    func clear() {
        taken.removeAll()
    }

    static func == (lhs: Board, rhs: Board) -> Bool {
        return lhs.taken == rhs.taken
    }
}

class Reversi {

    fileprivate var board: Board
    
    init(withBoard board: Board = Board()) {
        self.board = board
    }

    public func start() {
        board.clear()
        board.add(field: Field(column: .d, row: ._4, disk: .white))
        board.add(field: Field(column: .d, row: ._5, disk: .black))
        board.add(field: Field(column: .e, row: ._4, disk: .black))
        board.add(field: Field(column: .e, row: ._5, disk: .white))
    }

    public func move(to targetField: Field) {
        board.taken.append(targetField)

        getFlankedFieldsInAllDirection(forTargetField: targetField).forEach { $0.flipDisk() }
    }

    public func getNumberOfFieldsTaken(ofType type: Disk? = nil) -> Int {
        if let type = type {
            return board.taken.filter { $0.disk == type }.count
        }

        return board.taken.count
    }

    fileprivate func getFlankedFieldsInAllDirection(forTargetField targetField: Field) -> [Field] {
        return Direction.getValues().flatMap { getFlankedFields(inDirection: $0, forTargetField: targetField) }
    }

    fileprivate func getFlankedFields(inDirection direction: Direction, forTargetField targetField: Field) -> [Field] {
        var currentField = targetField
        var flankedFields: [Field] = []
        var isFlanked: Bool = false

        while let nextField = board.getNextFieldInDirection(previousField: currentField, direction: direction) {
            currentField = nextField
            if currentField.disk == targetField.disk {
                isFlanked = true
                break
            }

            flankedFields.append(currentField)
        }

        if !isFlanked {
            flankedFields.removeAll()
        }

        return flankedFields
    }
}

class ReversiSpec: QuickSpec {
    override func spec() {
        var board: Board!
        var game: Reversi!

        beforeEach {
            board = Board()
            game = Reversi(withBoard: board)
            game.start()
        }

        describe("start") {
            
            it("has 4 disks in a starting position") {
                expect(board).to(equal(Board(taken: [Field(column: .d, row: ._4, disk: .white),
                                                     Field(column: .d, row: ._5, disk: .black),
                                                     Field(column: .e, row: ._4, disk: .black),
                                                     Field(column: .e, row: ._5, disk: .white)])))
            }
        }

        describe("black player makes first move to D3") {

            beforeEach {
                game.move(to: Field(column: .d, row: ._3, disk: .black))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position D3") {
                expect(board.getField(column: .d, row: ._3)?.disk).to(equal(Disk.black))
            }

            it("has black disk on position D4") {
                expect(board.getField(column: .d, row: ._4)?.disk).to(equal(Disk.black))
            }
        }

        describe("black player makes first move to E6") {
            beforeEach {
                game.move(to: Field(column: .e, row: ._6, disk: .black))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position E6") {
                expect(board.getField(column: .e, row: ._6)?.disk).to(equal(Disk.black))
            }

            it("has black disk on position E5") {
                expect(board.getField(column: .e, row: ._5)?.disk).to(equal(Disk.black))
            }
        }

        describe("black player makes first move to F5") {
            beforeEach {
                game.move(to: Field(column: .f, row: ._5, disk: .black))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position F5") {
                expect(board.getField(column: .f, row: ._5)?.disk).to(equal(Disk.black))
            }

            it("has black disk on position E5") {
                expect(board.getField(column: .e, row: ._5)?.disk).to(equal(Disk.black))
            }
        }
    }
}
