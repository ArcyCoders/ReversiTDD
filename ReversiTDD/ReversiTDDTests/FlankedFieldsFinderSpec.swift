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
            // MARK: - right direction
            context("right direction") {
                it("returns one item when only one white piece between target and other black disk") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("BWB-----",
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

                it("returns no items when no matching piece is found after opponent's piece") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("BW------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(0))
                }

                it("returns six items when six white pieces are present between target and other black disk") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("BWWWWWWB",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(6))
                }

                it("returns no items when no matching piece is found after opponent's pieces") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("BWWWWWWW",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(0))
                }

                it("returns no items when an empty field is found found before first opponent's piece") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("B-WWWWWW",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(0))
                }

                it("returns no items when an empty field is found before next matching piece") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("B-BWWWWW",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(0))
                }

                it("returns no items in right direction when an empty field is found after opponent's piect and before next matching piece") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("BW_BWWWW",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(0))
                }
            }

            // MARK: - left direction
            context("left direction") {
                it("returns one item in left direction when only one white piece between target and other black disk") {
                    targetField = Field(column: .h, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("-----BWB",
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

                it("returns no items in left direction when no matching piece is found after opponent's piece") {
                    targetField = Field(column: .a, row: ._1, disk: Disk(currentColor: .black))
                    board = BoardStringLoader().load("------WB",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------"
                    )
                    flankedFields = flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board)

                    expect(flankedFields.count).to(equal(0))
                }
            }
        }
    }
}
