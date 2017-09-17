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

enum Row: Int {
    case a, b, c, d, e, f, g, h
}

enum Column: Int {
    case _1, _2, _3, _4, _5, _6, _7, _8
}

enum Disk: Int {
    case white, black
}

struct Field: Equatable, Hashable {
    let row: Row
    let column: Column
    let disk: Disk?

    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column && lhs.disk == rhs.disk
    }

    func isOnTheSamePosition(as otherField: Field) -> Bool {
        return row == otherField.row && column == otherField.column
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

    func getField(row: Row, column: Column) -> Field? {

        return taken.filter { $0.row == row && $0.column == column }.first
    }

    func clear() {
        taken.removeAll()
    }

    func replace(sourceField: Field, with targetField: Field) {
        guard let sourceFieldIndex = taken.index(of: sourceField) else { return }

        taken[sourceFieldIndex] = targetField
    }

    static func == (lhs: Board, rhs: Board) -> Bool {
        return lhs.taken == rhs.taken
    }
}

class Reversi {
    enum MoveError: Error {
        case fieldAlreadyTaken
    }

    fileprivate var board: Board
    
    init(withBoard board: Board = Board()) {
        self.board = board
    }

    public func start() {
        board.clear()
        board.add(field: Field(row: .d, column: ._4, disk: .white))
        board.add(field: Field(row: .d, column: ._5, disk: .black))
        board.add(field: Field(row: .e, column: ._4, disk: .black))
        board.add(field: Field(row: .e, column: ._5, disk: .white))
    }

    public func move(to targetField: Field) throws {
        if board.taken.contains(where: { $0.isOnTheSamePosition(as: targetField) }) {
            throw MoveError.fieldAlreadyTaken
        }

        board.taken.append(targetField)
//        flipNeighbouringDisks(for: targetField.x, y: targetField.y)
    }

    public func getNumberOfFieldsTaken(ofType type: Disk? = nil) -> Int {
        if let type = type {
            return board.taken.filter { $0.disk == type }.count
        }

        return board.taken.count
    }

//    fileprivate func flipNeighbouringDisks(for x: Int, y: Int) {
//        let rows = [x - 1, x, x + 1]
//        let columns = [y - 1, y, y + 1]
//
//        guard let startingField = board.getField(x: x, y: y),
//              let startingDisk = startingField.disk
//        else { return }
//
//        for row in rows {
//            for column in columns {
//                if let neighbourField = board.getField(x: row, y: column),
//                   let neighbourDisk = neighbourField.disk {
//                    if neighbourDisk != startingDisk {
//                        board.replace(sourceField: neighbourField, with: Field(x: neighbourField.x, y: neighbourField.y, disk: startingDisk))
//                    }
//                }
//            }
//        }
//    }
}

class ReversiSpec: QuickSpec {
    override func spec() {
        var board: Board!
        var game: Reversi!

        beforeEach {
            board = Board()
        }

        describe("start") {

            beforeEach {
                game = Reversi(withBoard: board)
                game.start()
            }
            
            it("has 4 disks in a starting position") {
                expect(board).to(equal(Board(taken: [Field(row: .d, column: ._4, disk: .white),
                                                     Field(row: .d, column: ._5, disk: .black),
                                                     Field(row: .e, column: ._4, disk: .black),
                                                     Field(row: .e, column: ._5, disk: .white)])))
            }
        }

        describe("black player makes first move to D3") {

            beforeEach {
                game = Reversi(withBoard: board)
                game.start()
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position D3") {
                expect(board.getField(row: .d, column: ._3)?.disk).to(equal(Disk.black))
            }

            it("has black disk on position D4") {
                expect(board.getField(row: .d, column: ._4)?.disk).to(equal(Disk.black))
            }
        }

        // player makes a move
        // empty field
        // next to field with disk of opposite player
        // in vertical, horizontal


        // start game
        // select player
        // if current can make move
        //  forfeit move
        // if no player can make move
        //  make move
        // else
        //  finish game
        // who won, who lost?
    }
}
