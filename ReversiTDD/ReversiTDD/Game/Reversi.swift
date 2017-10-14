//
//  Reversi.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public class Reversi {
    private var board: Board
    private let flankedFieldsFinder: FlankedFieldsFinder
    private(set) var currentPlayer: Disk.Color

    public init(withBoard board: Board = Board(), withFlankedFieldsFinder flankedFieldsFinder: FlankedFieldsFinder = FlankedFieldsFinder()) {
        self.currentPlayer = .black
        self.board = board
        self.flankedFieldsFinder = flankedFieldsFinder
    }

    public func start() {
        board.clear()
        board.set(field: Field(column: .d, row: ._4, disk: Disk(currentColor: .white)))
        board.set(field: Field(column: .d, row: ._5, disk: Disk(currentColor: .black)))
        board.set(field: Field(column: .e, row: ._4, disk: Disk(currentColor: .black)))
        board.set(field: Field(column: .e, row: ._5, disk: Disk(currentColor: .white)))

        currentPlayer = .black
    }

    public func load(currentPlayer: Disk.Color, board: Board) {
        self.currentPlayer = currentPlayer
        self.board = board
    }

    // TODO: handle invalid move
    public func move(to targetField: Field) {
        board.set(field: targetField)

        flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board, forColor: currentPlayer).forEach { $0.disk?.turnOver() }

        switchPlayer()
    }

    public func getValidMoves(forPlayer player: Disk.Color) -> [Field] {
        let allOponentsField = board.getAllFields(containingDiskWithColor: player.oppositeColor)
        let allEmptyFieldsNeighbouringOpponentsFields = allOponentsField.flatMap { board.getNeighbouringFields(forField: $0).filter { $0.isEmpty } }

        let validMovesWithDuplicates = allEmptyFieldsNeighbouringOpponentsFields.filter { !flankedFieldsFinder.getAllFlankedFields(byTargetField: $0, onBoard: board, forColor: player).isEmpty }
        let validMovesWithoutDuplicates = Array(Set(validMovesWithDuplicates))

        return validMovesWithoutDuplicates
    }

    fileprivate func switchPlayer() {
        currentPlayer = currentPlayer == .white ? .black : .white
    }
}
