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
    case incorrectCharacterPassed
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
        guard representation.count == 64 else { throw ASCIIImporterError.wrongCharactersCount }
        
        let whiteDiskCharacter: Character = "w"
        let blackDiskCharacter: Character = "b"
        let emptyFieldCharacter: Character = "."
        
        var x = 0
        var y = 0
        var fields =  Array<Field>()
        
        for char in representation.characters
        {            
            switch char
            {
                case whiteDiskCharacter: fields.append(Field(x: x, y: y, disk: Disk.White))
                case blackDiskCharacter: fields.append(Field(x: x, y: y, disk: Disk.Black))
                case emptyFieldCharacter: break
                default: throw ASCIIImporterError.incorrectCharacterPassed
            }

            if x < 7 {
                x += 1
            }
            else {
                x = 0
                y += 1
            }
        }
        
        return Board(taken: fields)
    }
}
