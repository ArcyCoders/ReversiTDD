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


//        describe("init(ascii:)")
//        {            
//            it("properly loads board from ascii representation")
//            {
//                let input =
//                "________"
//                "________"
//                "________"
//                "___o*___"
//                "___*o___"
//                "________"
//                "________"
//                "________"
//                let board = Board(ascii: input)
//                let output = board.output()
//                expect(input).to(equal(output))
//            }
//        }
    }
}
