//
//  BoardStringLoader.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public class BoardStringLoader {
    public init() {}

    public func load(_ rows: String...) -> Board {
        let defaultBoard = Board()
        let rows = rows.filter { $0.characters.count == 8 }

        guard rows.count == 8 else { return defaultBoard }

        let resultBoard = Board()
        for rowIndex in 0..<8 {
            for columnIndex in 0..<8 {
                let rowString = rows[rowIndex]
                let disk: Disk? = getField(forCharacter: Array(rowString)[columnIndex])

                if let disk = disk,
                   let column = Column(rawValue: columnIndex),
                   let row = Row(rawValue: rowIndex) {
                    resultBoard.set(field: Field(column: column, row: row, disk: disk))
                }
            }
        }

        return resultBoard
    }

    private func getField(forCharacter fieldCharacter: Character) -> Disk? {
        switch fieldCharacter {
            case "W": return Disk(currentColor: .white)
            case "B": return Disk(currentColor: .black)
            default: return nil
        }
    }
}
