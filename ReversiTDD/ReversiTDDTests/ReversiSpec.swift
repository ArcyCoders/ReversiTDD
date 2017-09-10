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
    enum ApplyMoveError: Error {
        case fieldAlreadyTaken
    }

    fileprivate var taken: [Field]

    var numberOfFieldsTaken: Int {
        return taken.count
    }
    
    init(taken: [Field]) {
        self.taken = taken
    }

    func move(to targetField: Field) throws {
        if taken.contains(where: { $0.x == targetField.x && $0.y == targetField.y }) {
            throw ApplyMoveError.fieldAlreadyTaken
        }

        taken.append(targetField)
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
    var numberOfFieldsTaken: Int { return board.numberOfFieldsTaken }

    fileprivate(set) var board: Board
    
    init() {
        board = Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
    }

    func move(to targetField: Field) throws {
        try board.move(to: targetField)
    }
}

class ReversiSpec: QuickSpec {
    override func spec() {
        
        describe("start") {
            
            it("has 4 disk in a starting position") {
                let game = Reversi()
                
                expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])))
            }
            
        }

        // Rules:
        // 1. performed by dark
        // 2. must c4, d3, e6, f5
        // 3. must flip white disk between dark ones
        describe("first move") {

            it("has total of 5 disks on board") {
                let game = Reversi()
                try? game.move(to: Field(x: 2, y: 3, disk: .Black))

                expect(game.numberOfFieldsTaken).to(equal(5))
            }
        }
    }
}
