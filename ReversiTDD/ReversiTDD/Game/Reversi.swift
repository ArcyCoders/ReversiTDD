//
//  Reversi.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Direction {
    let vertical: VerticalDirection
    let horizontal: HorizontalDirection

    static func getValues() -> [Direction] {
        var directions: [Direction] = []

        for verticalDirection in VerticalDirection.getValues() {
            for horizontalDirection in HorizontalDirection.getValues() {
                directions.append(Direction(vertical: verticalDirection, horizontal: horizontalDirection))
            }
        }

        return directions
    }
}

enum VerticalDirection {
    case up
    case down
    case none

    static func getValues() -> [VerticalDirection] {
        return [.up, .down, .none]
    }
}

enum HorizontalDirection {
    case left
    case right
    case none

    static func getValues() -> [HorizontalDirection] {
        return [.left, .right, .none]
    }
}

func <<T: RawRepresentable>(a: T, b: T) -> Bool where T.RawValue: Comparable {
    return a.rawValue < b.rawValue
}

class Reversi {
    fileprivate var board: Board
    fileprivate let flankedFieldsFinder: FlankedFieldsFinder
    fileprivate(set) var currentPlayer: Disk.Color

    init(withBoard board: Board = Board(), withFlankedFieldsFinder flankedFieldsFinder: FlankedFieldsFinder = FlankedFieldsFinder()) {
        self.currentPlayer = .black
        self.board = board
        self.flankedFieldsFinder = flankedFieldsFinder
    }

    public func start() {
        board.clear()
        board.add(field: Field(column: .d, row: ._4, disk: Disk(currentColor: .white)))
        board.add(field: Field(column: .d, row: ._5, disk: Disk(currentColor: .black)))
        board.add(field: Field(column: .e, row: ._4, disk: Disk(currentColor: .black)))
        board.add(field: Field(column: .e, row: ._5, disk: Disk(currentColor: .white)))

        currentPlayer = .black
    }

    // TODO: handle invalid move
    public func move(to targetField: Field) {
        board.taken.append(targetField)

        flankedFieldsFinder.getAllFlankedFields(byTargetField: targetField, onBoard: board).forEach { $0.disk?.turnOver() }

        switchPlayer()
    }

    public func getNumberOfFieldsTaken(ofColor color: Disk.Color? = nil) -> Int {
        if let color = color {
            return board.taken.filter { $0.disk?.currentColor == color }.count
        }

        return board.taken.count
    }

    fileprivate func switchPlayer() {
        currentPlayer = currentPlayer == .white ? .black : .white
    }
}
