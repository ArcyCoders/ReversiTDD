//
//  BoardSpec.swift
//  ReversiTDDTests
//
//  Created by Michal Miedlarz on 07.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ReversiTDD

class BoardSpec: QuickSpec {
    override func spec() {
        describe("Board")
        {
            context(".detectFieldsToPlaceDisk")
            {
                var startingBoard: Board {
                    return Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black),
                                         Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
                }
                
                it("Should return list of valid fields for starting position") {
                    expect(startingBoard.detectFieldsToPlaceDisk()).notTo(beEmpty())
                }
                
                it("Should return list of fields valid to place disk") {
                    let fields = startingBoard.detectFieldsToPlaceDisk()
                    fields.forEach()
                    {
                        field in
                        expect { try startingBoard.add(field: field) }.notTo(throwError())
                    }
                }
            }
        }
    }
}

