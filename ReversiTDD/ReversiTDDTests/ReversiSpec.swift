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

enum Disk: Int {
    case White
    case Black
}

struct Field: Equatable, Hashable {
    let x: Int
    let y: Int
    let disk: Disk?

    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.disk == rhs.disk
    }

    public var hashValue: Int {
        let diskValue = disk?.rawValue ?? 0

        return "x:\(x)y:\(y)disk:\(diskValue)".hashValue
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

    func getField(x: Int, y: Int) -> Field? {

        return taken.filter { $0.x == x && $0.y == y }.first
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

func == (tuple1:(Int, Int, Disk),tuple2:(Int, Int, Disk)) -> Bool
{
    return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1) && (tuple1.2 == tuple2.2)
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
        board.add(field: Field(x: 3, y: 3, disk: .White))
        board.add(field: Field(x: 3, y: 4, disk: .Black))
        board.add(field: Field(x: 4, y: 3, disk: .Black))
        board.add(field: Field(x: 4, y: 4, disk: .White))
    }

    public func move(to targetField: Field) throws {
        if board.taken.contains(where: { $0.x == targetField.x && $0.y == targetField.y }) {
            throw MoveError.fieldAlreadyTaken
        }

        board.taken.append(targetField)
        flipNeighbouringDisks(for: targetField.x, y: targetField.y)
    }

    public func getNumberOfFieldsTaken(ofType type: Disk? = nil) -> Int {
        if let type = type {
            return board.taken.filter { $0.disk == type }.count
        }

        return board.taken.count
    }

    fileprivate func flipNeighbouringDisks(for x: Int, y: Int) {
        let rows = [x - 1, x, x + 1]
        let columns = [y - 1, y, y + 1]

        guard let startingField = board.getField(x: x, y: y),
              let startingDisk = startingField.disk
        else { return }

        for row in rows {
            for column in columns {
                if let neighbourField = board.getField(x: row, y: column),
                   let neighbourDisk = neighbourField.disk {
                    if neighbourDisk != startingDisk {
                        board.replace(sourceField: neighbourField, with: Field(x: neighbourField.x, y: neighbourField.y, disk: startingDisk))
                    }
                }
            }
        }
    }
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
                expect(board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])))
            }
        }

        describe("black player makes first move to D3") {

            beforeEach {
                game = Reversi(withBoard: board)
                game.start()
            }

            it("has black as current player") {
                // TODO:
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position D3") {
                expect(board.getField(x: 3, y: 2)?.disk).to(equal(Disk.Black))
            }

            it("has black disk on position D4") {
                expect(board.getField(x: 3, y: 3)?.disk).to(equal(Disk.Black))
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
