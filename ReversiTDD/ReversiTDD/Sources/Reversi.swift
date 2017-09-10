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
    
    init() {
        board = Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
    }
    
    func move(field: Field) throws {
        do {
            try board.add(field: field)
        }
        catch let err
        {
            throw err
        }
    }
}
