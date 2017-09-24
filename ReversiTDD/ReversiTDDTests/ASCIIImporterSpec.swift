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
            
            context(".parse")
            {
                it("should return empty board for given ascii representation")
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
                
                it("should return starting board from given ascii representation")
                {
                    let representation: String =
                                                "........" +
                                                "........" +
                                                "........" +
                                                "...wb..." +
                                                "...bw..." +
                                                "........" +
                                                "........" +
                                                "........"
                    let importer = ASCIIImporter(asciiRepresentation: representation)
                    expect{ try importer.parse() }.to(equal(Board(taken: [ Field(x: 3, y: 3, disk: .White),
                                                                           Field(x: 3, y: 4, disk: .Black),
                                                                           Field(x: 4, y: 3, disk: .Black),
                                                                           Field(x: 4, y: 4, disk: .White)])))
                }
                
                fit("should return custom, impossible to achieve by normal play board from given ascii representation")
                {
                    let representation: String =
                            "w......w" +
                            "........" +
                            "........" +
                            "b......b" +
                            "...bb..." +
                            "........" +
                            "........" +
                            "w......w"
                    let importer = ASCIIImporter(asciiRepresentation: representation)
                    expect{ try importer.parse() }.to(equal(Board(taken: [ Field(x: 0, y: 0, disk: .White),
                                                                           Field(x: 7, y: 0, disk: .White),
                                                                           
                                                                           Field(x: 0, y: 3, disk: .Black),
                                                                           Field(x: 7, y: 3, disk: .Black),
                                                                           
                                                                           Field(x: 3, y: 4, disk: .Black),
                                                                           Field(x: 4, y: 4, disk: .Black),
                                                                           
                                                                           Field(x: 0, y: 7, disk: .White),
                                                                           Field(x: 7, y: 7, disk: .White)])))
                }
            }
        }
    }
}
