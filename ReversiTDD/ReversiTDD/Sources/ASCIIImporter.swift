//
//  ASCIIImporter.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 24.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum ASCIIImporterError: Error
{
    case wrongCharactersCount
}

class ASCIIImporter
{
    private let representation: String
    init(asciiRepresentation representation: String)
    {
        self.representation = representation
    }
    
    func parse() throws -> Board
    {
        return Board(taken: [])
    }
}
