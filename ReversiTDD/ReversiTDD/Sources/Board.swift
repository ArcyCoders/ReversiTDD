//
//  Board.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 10.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import UIKit

class Board: Equatable {
    var taken: [Field]
    
    init(taken: [Field]) {
        self.taken = taken
    }
    
    func add(field: Field) throws
    {
        guard fieldAt(x: field.x, y: field.y) == nil
        else { throw ReversiError.positionTaken }
        
        guard !adjacentFields(toField: field).isEmpty
        else { throw ReversiError.noAdjacentDisks }
        
        let fieldsToRotate = detectFieldsToRotate(field: field)
        guard !fieldsToRotate.isEmpty else { throw ReversiError.noDisksToTurn }
        
        taken = taken.filter { !fieldsToRotate.contains($0) }
        taken.append(contentsOf: fieldsToRotate.map({ Field(x: $0.x, y: $0.y, disk: field.disk) }) )
        
        taken.append(field)
    }
    
    func adjacentFields(toField field: Field) -> Array<Field>
    {
        return taken.filter
        {
            $0.x == field.x && (($0.y == field.y + 1) || ($0.y == field.y - 1)) ||
            $0.y == field.y && (($0.x == field.x + 1) || ($0.x == field.x - 1)) ||
            $0.x + 1 == field.x && $0.y + 1 == field.y ||
            $0.x + 1 == field.x && $0.y - 1 == field.y ||
            $0.x - 1 == field.x && $0.y + 1 == field.y ||
            $0.x - 1 == field.x && $0.y - 1 == field.y
        }
    }
    
    func detectFieldsToRotate(field: Field) -> Array<Field>
    {
        var fieldsToRotate = Array<Field>()
        
        let oppositeAdjacentFields = adjacentFields(toField: field).filter{ $0.disk != field.disk }
        oppositeAdjacentFields.forEach
        {
            let delta = (x: $0.x - field.x, y: $0.y - field.y)
            
            var fieldsInLine = Array<Field>()
            var nextField: Field? = $0
            while true
            {
                guard let f = nextField else { break }
                fieldsInLine.append(f)
                nextField = fieldAt(x: f.x + delta.x, y: f.y + delta.y)
                
                if nextField == nil { break }
                if nextField?.disk == field.disk
                {
                    fieldsToRotate.append(contentsOf: fieldsInLine)
                    break
                }
            }
        }
        
        return fieldsToRotate
    }
    
    func detectFieldsToPlaceDisk() -> Array<Field> {
        var blackFields = Array<Field>()
        var whiteFields = Array<Field>()
        
        for x in 0...7
        {
            for y in 0...7
            {
                blackFields.append( Field(x: x, y: y, disk: .Black) )
                whiteFields.append( Field(x: x, y: y, disk: .White) )
            }
        }
        
        return (blackFields + whiteFields).filter({ isFieldValid(field: $0)})
    }
    
    func isFieldValid(field: Field) -> Bool {
        guard fieldAt(x: field.x, y: field.y) == nil,
              !adjacentFields(toField: field).isEmpty,
              !detectFieldsToRotate(field: field).isEmpty
        else { return false }
        return true
    }
    
    // MARK: Utils
    func fieldAt(x: Int, y: Int) -> Field?
    {
        return taken.filter({ $0.x == x && $0.y == y}).first
    }
    
    // MARK: Equatable
    static func == (lhs: Board, rhs: Board) -> Bool
    {
        return Set(lhs.taken) == Set(rhs.taken)
    }
}
