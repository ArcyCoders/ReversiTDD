//
//  FlankedFieldsFinderSpec.swift
//  ReversiTDDTests
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ReversiTDD

class FlankedFieldsFinderSpec: QuickSpec {
    override func spec() {
        var flankedFieldsFinder: FlankedFieldsFinder!
        var board: Board!
        var flankedFields: [Field]!
        var targetField: Field!

        beforeEach {
            flankedFieldsFinder = FlankedFieldsFinder()
            flankedFields = []
        }

        describe("getAllFlankedFields") {
            it("returns single item when only one white piece on between target and other black when checking right") {
                targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                board = BoardStringLoader().load(from: "BWB-----",
                                                       "--------",
                                                       "--------",
                                                       "--------",
                                                       "--------",
                                                       "--------",
                                                       "--------",
                                                       "--------"
                )
                flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                expect(flankedFields.count).to(equal(1))
            }
        }
    }
}
