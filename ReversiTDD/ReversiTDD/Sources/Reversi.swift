//
//  Reversi.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 10.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

class Reversi {
    var board: Board
    var lastDiskColor: Disk? = .White
    
    init() {
        board = Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
    }
    
    func move(field: Field) throws {
        guard field.disk != lastDiskColor else {
            throw ReversiError.incorrectDiskColor
        }
        
        do {
            try board.add(field: field)
            lastDiskColor = field.disk
        }
        catch let err
        {
            throw err
        }
    }
}
