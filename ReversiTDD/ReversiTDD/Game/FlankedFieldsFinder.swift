//
//  FlankedFieldsFinder.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public class FlankedFieldsFinder {
    public init() {}

    public func getAllFlankedFields(byTargetField targetField: Field, onBoard board: Board, forColor playerColor: Disk.Color) -> [Field] {
        return Direction.getValues().flatMap { getFlankedFields(inDirection: $0, forTargetField: targetField, onBoard: board, forColor: playerColor) }
    }

    fileprivate func getFlankedFields(inDirection direction: Direction, forTargetField targetField: Field, onBoard board: Board, forColor playerColor: Disk.Color) -> [Field] {
        var currentField = targetField
        var flankedFields: [Field] = []
        var isFlanked: Bool = false

        while let nextField = board.getNextFieldInDirection(fromPreviousField: currentField, direction: direction),
              nextField != currentField,
              !nextField.isEmpty {
            currentField = nextField
            if currentField.disk?.currentColor == playerColor {
                isFlanked = true
                break
            }

            flankedFields.append(currentField)
        }

        if !isFlanked {
            flankedFields.removeAll()
        }

        return flankedFields
    }
}
