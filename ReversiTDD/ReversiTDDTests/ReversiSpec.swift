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

struct Field: Equatable {
    let x: Int
    let y: Int
    let disk: Disk?

    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.disk == rhs.disk
    }
}

class Board: Equatable {
    var taken: [Field]
    
    init(taken: [Field]) {
        self.taken = taken
    }

    func getField(x: Int, y: Int) -> Field? {

        return taken.filter { $0.x == x && $0.y == y }.first
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

    fileprivate(set) var board: Board
    
    init() {
        board = Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
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
        var game: Reversi!

        beforeEach {
            game = Reversi()
        }

        describe("start") {
            
            it("has 4 disk in a starting position") {
                expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])))
            }
            
        }

        // Rules:
        // 1. performed by dark
        // 2. must c4, d3, e6, f5
        // 3. must flip white disk between dark ones
        // Result:
        // 1. 5 total disks on board
        // 2. 4 black disks on board
        // 3. 1 white disk on board
        describe("first move") {
            beforeEach {
                try? game.move(to: Field(x: 2, y: 3, disk: .Black))
            }

            it("has total of 5 disks on board") {

                expect(game.getNumberOfFieldsTaken()).to(equal(5))
            }

            it("has total of 4 black disks on board") {
                expect(game.getNumberOfFieldsTaken(ofType: .Black)).to(equal(4))
            }

            it("has total of 1 white disks on board") {
                expect(game.getNumberOfFieldsTaken(ofType: .White)).to(equal(1))
            }
        }
    }
}
