//
//  Reversi.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum ErrorType
{
    case wrongPlayer
    case illegalMove
}

class Reversi
{
    fileprivate(set) var board: Board
    fileprivate(set) var currentPlayer: Player

    func move(player: Player, field: Field) -> ErrorType?
    {
        if player == currentPlayer
        {
            return .wrongPlayer
        }

        var emptyFields = board.emptyFields
        var blackFields = board.blackFields
        var whiteFields = board.whiteFields

        guard let index = emptyFields.index(of: field) else { return .illegalMove }

        emptyFields.remove(at: index)

        if player == .black
        {
            blackFields.append(field)
            let disksToSwap = findDisksForSwap(for: player, field: field, blackFields: blackFields, whiteFields: whiteFields)
            blackFields.append(contentsOf: disksToSwap)
            whiteFields = whiteFields.filter { !disksToSwap.contains($0) }
        }
        else
        {
            whiteFields.append(field)
            let disksToSwap = findDisksForSwap(for: player, field: field, blackFields: blackFields, whiteFields: whiteFields)
            whiteFields.append(contentsOf: disksToSwap)
            blackFields = blackFields.filter { !disksToSwap.contains($0) }
        }

        board = Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
        currentPlayer = player.next()

        return nil
    }

    init()
    {
        // Initial board
        //
        //  abcdefgh
        // 1________
        // 2________
        // 3________
        // 4___o*___
        // 5___*o___
        // 6________
        // 7________
        // 8________
        let array = Array(0...63)
        let emptyFields = array.flatMap { (index) -> Field? in
            let y = index % Row.count()
            let x = index / Column.count()
            if (x == 3 || x == 4) && (y == 3 || y == 4) { return nil }
            return Field(Row(rawValue: y)!, Column(rawValue: x)!)
        }
        let blackFields = [Field(._5, .d), Field(._4, .e)]
        let whiteFields = [Field(._4, .d), Field(._5, .e)]
        
        board = Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
        currentPlayer = Player.black
    }
}

extension Reversi
{
    fileprivate func findDisksForSwap(`for` player: Player, field: Field, blackFields: [Field], whiteFields: [Field]) -> [Field]
    {
        var disksToSwap = [Field]()
        let playerFields = (player == .black) ? blackFields : whiteFields
        let opponentFields = (player == .black) ? whiteFields : blackFields

        DirectionType.all().forEach { (direction) in
            let fields = findFields(startField: field, direction: direction, playerFields: playerFields, opponentFields: opponentFields)
            disksToSwap.append(contentsOf: fields)
        }

        return disksToSwap
    }

    fileprivate func findFields(startField: Field, direction: DirectionType.Direction, playerFields: [Field], opponentFields: [Field]) -> [Field]
    {
        var resultFields = [Field]()
//
//        var x: FieldType = startField.x
//        var y: FieldType = startField.y
//        var nextField: Field?

//        repeat
//        {
//            x += direction.vx
//            y += direction.vy
//            nextField = Field(x: x, y: y)
//            guard x >= 0 && x < 8 && y >= 0 && y < 8 else { break }
//            guard let nextField = nextField, opponentFields.contains(nextField) else { break }
//            resultFields.append(nextField)
//
//        } while(true)

        return resultFields
    }
}







