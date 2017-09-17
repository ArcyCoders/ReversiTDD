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
    }

    init()
    {
        board = Board()
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

        var x = startField.x
        var y = startField.y
        var nextField: Field?

        repeat
        {
            x += direction.vx
            y += direction.vy
            nextField = Field(x: x, y: y)
            guard x >= 0 && x < 8 && y >= 0 && y < 8 else { break }
            guard let nextField = nextField, opponentFields.contains(nextField) else { break }
            resultFields.append(contentsOf: nextField)

        } while(true)

        return resultFields
    }
}







