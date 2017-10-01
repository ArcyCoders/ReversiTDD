//
//  BoardSpec.swift
//  ReversiTDDTests
//
//  Created by Pawel Leszkiewicz on 23.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ReversiTDD

class BoardSpec: QuickSpec
{
    override func spec()
    {
        describe("board properties")
        {
            it("should have number of fields proportional to rows and columns count")
            {
                expect(Board.fieldsCount) == Row.count() * Column.count()
            }
        }

        describe("== operator")
        {
            it("should return true for two identical empty boards")
            {
                let board1 = Board(emptyFields: [], blackFields: [], whiteFields: [])
                let board2 = Board(emptyFields: [], blackFields: [], whiteFields: [])
                expect(board1).to(equal(board2))
            }

            it("should return true for two identical random boards")
            {
                let board1 = Board.random()
                let board2 = Board(emptyFields: board1.emptyFields, blackFields: board1.blackFields, whiteFields: board1.whiteFields)
                expect(board1).to(equal(board2))
            }

            it("should return false for two different random boards")
            {
                let board1 = Board.random()
                let board2 = Board.random()
                expect(board1).toNot(equal(board2))
            }

            it("should return true for two identical custom created boards")
            {
                let input = [
                  //abcdefgh
                   "___**___", //1
                   "_o______", //2
                   "________", //3
                   "___o*___", //4
                   "___*o___", //5
                   "________", //6
                   "_**___o_", //7
                   "________"  //8
                    ].joined()
                let board1 = Board(ascii: input)
                expect(board1).toNot(beNil())

                let blackFields = Set<Field>([Field(._1, .d), Field(._1, .e), Field(._4, .e), Field(._5, .d), Field(._7, .b), Field(._7, .c)])
                let whiteFields = Set<Field>([Field(._7, .g), Field(._4, .d), Field(._5, .e), Field(._2, .b)])
                let emptyFields = Set<Field>(Field.all()).subtracting(blackFields.union(whiteFields))
                let board2 = Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
                expect(board1).to(equal(board2))
            }

            it("should return false for two different custom created boards")
            {
                let input = [
                    //abcdefgh
                    "___**___", //1
                    "_o______", //2
                    "________", //3
                    "___o*___", //4
                    "___*o___", //5
                    "________", //6
                    "_**___o_", //7
                    "________"  //8
                    ].joined()
                let board1 = Board(ascii: input)
                expect(board1).toNot(beNil())

                let whiteFields = Set<Field>([Field(._1, .d), Field(._1, .e), Field(._4, .e), Field(._5, .d), Field(._7, .b), Field(._7, .c)])
                let blackFields = Set<Field>([Field(._7, .g), Field(._4, .d), Field(._5, .e), Field(._2, .b)])
                let emptyFields = Set<Field>(Field.all()).subtracting(blackFields.union(whiteFields))
                let board2 = Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
                expect(board1).toNot(equal(board2))
            }
        }

        describe("output()")
        {
            it("should return identical output as ascii input")
            {
                let input = Board.randomAsciiRepresentation()
                let board = Board(ascii: input)
                expect(board).toNot(beNil())

                let output = board!.output()
                expect(input).to(equal(output))
            }
        }
    }
}
