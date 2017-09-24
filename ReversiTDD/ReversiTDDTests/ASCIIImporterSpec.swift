//
//  ASCIIImporterSpec.swift
//  ReversiTDDTests
//
//  Created by Michal Miedlarz on 24.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

import Foundation
import Quick
import Nimble
@testable import ReversiTDD

class ASCIIImporterSpec: QuickSpec
{
    override func spec()
    {
        describe("ASCIIImporter")
        {
            it("should be initialized with ASCII representation of board")
            {
                _ = ASCIIImporter(asciiRepresentation: "")
            }
            
            it("should return proper board for given ascii representation")
            {
                let representation: String =
                                            "........" +
                                            "........" +
                                            "........" +
                                            "........" +
                                            "........" +
                                            "........" +
                                            "........" +
                                            "........"
                let importer = ASCIIImporter(asciiRepresentation: representation)
                expect{ try importer.parse() }.to(equal(Board(taken: [])))
            }
        }
    }
}
