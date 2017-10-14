//
//  Reversi.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public enum ErrorType: String
{
    case wrongPlayer = "Wrong player."
    case moveIsNotAllowed = "This move is not allowed."
}

public class Reversi
{
	public fileprivate(set) var board: Board
    public fileprivate(set) var currentPlayer: Player

    public init()
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
        let array = Array(0...(Board.fieldsCount - 1))
        let midX: Int = Column.count() / 2
        let midY: Int = Row.count() / 2
        let emptyFields = Set<Field>(array.flatMap { (index) -> Field? in
            let y = index % Row.count()
            let x = index / Column.count()
            if (x == midX || x == (midX - 1)) && (y == midY || y == (midY - 1)) { return nil }
            return Field(Row(rawValue: y)!, Column(rawValue: x)!)
        })

        // Force unwraps is safe here if columns/rows > 1
        let midColumn1 = Column(rawValue: midX)!
        let midColumn2 = Column(rawValue: midX - 1)!
        let midRow1 = Row(rawValue: midY)!
        let midRow2 = Row(rawValue: midY - 1)!
        let blackFields = Set<Field>([Field(midRow1, midColumn2), Field(midRow2, midColumn1)])
        let whiteFields = Set<Field>([Field(midRow2, midColumn2), Field(midRow1, midColumn1)])
        
        board = Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
        currentPlayer = Player.black
    }

    public init(board: Board, player: Player)
    {
        self.board = board
        self.currentPlayer = player
    }

    public var isRunning: Bool { return canMove(player: .black) || canMove(player: .white) }
    public func canMove(player: Player) -> Bool { return !possibleMoves(for: player).isEmpty }
    public func getPlayerFields(_ player: Player) -> Set<Field> { return (player == .black) ? board.blackFields : board.whiteFields }
    public func getOpponentFields(_ player: Player) -> Set<Field> { return (player == .black) ? board.whiteFields : board.blackFields }

    public func possibleMoves(for player: Player) -> Set<Field>
    {
        var possibleMoves = Set<Field>()

        let emptyFields = board.emptyFields
        let playerFields = getPlayerFields(player)
        let opponentFields = getOpponentFields(player)
        emptyFields.forEach { (field) in
            let disksToSwap = self.findDisksToSwap(for: player, field: field, playerFields: playerFields, opponentFields: opponentFields)
            if !disksToSwap.isEmpty
            {
                possibleMoves.insert(field)
            }
        }

        return possibleMoves
    }

    @discardableResult
    public func move(player: Player, field: Field) -> ErrorType?
    {
        let emptyFields = board.emptyFields
        guard emptyFields.contains(field) else { return .moveIsNotAllowed }

        var playerFields = getPlayerFields(player)
        var opponentFields = getOpponentFields(player)
        let disksToSwap = findDisksToSwap(for: player, field: field, playerFields: playerFields, opponentFields: opponentFields)
        // If there is no disks to swap then current player has no moves
        if disksToSwap.isEmpty { return .moveIsNotAllowed }

        playerFields.insert(field)
        playerFields.formUnion(disksToSwap)
        opponentFields.subtract(disksToSwap)

        let newEmptyFields = emptyFields.subtracting(Set<Field>([field]))
        let newBlackFields = (player == .black) ? playerFields : opponentFields
        let newWhiteFields = (player == .black) ? opponentFields : playerFields

        board = Board(emptyFields: newEmptyFields, blackFields: newBlackFields, whiteFields: newWhiteFields)

        return nil
    }
}

extension Reversi
{
    fileprivate func findDisksToSwap(`for` player: Player, field: Field, playerFields: Set<Field>, opponentFields: Set<Field>) -> Set<Field>
    {
        var disksToSwap = Set<Field>()
        DirectionType.all().forEach { (direction) in
            let fields = findFields(startField: field, direction: direction, playerFields: playerFields, opponentFields: opponentFields)
            disksToSwap.formUnion(fields)
        }

        return disksToSwap
    }

    fileprivate func findFields(startField: Field, direction: DirectionType.Direction, playerFields: Set<Field>, opponentFields: Set<Field>) -> Set<Field>
    {
        guard !playerFields.contains(startField), !opponentFields.contains(startField) else { return Set<Field>() }

        var resultFields = Set<Field>()
        var column: Column = startField.column
        var row: Row = startField.row

        repeat
        {
            guard let nextColumn = Column(rawValue: column.rawValue + direction.vx) else { return Set<Field>() }
            guard let nextRow = Row(rawValue: row.rawValue + direction.vy) else { return Set<Field>() }

            let nextField = Field(nextRow, nextColumn)
            if opponentFields.contains(nextField)
            {
                // continue
                resultFields.insert(nextField)
            }
            else if playerFields.contains(nextField)
            {
                // player field, break here
                break
            }
            else
            {
                // Empty field, stop here
                return Set<Field>()
            }

            column = nextColumn
            row = nextRow

        } while(true)

        return resultFields
    }
}
