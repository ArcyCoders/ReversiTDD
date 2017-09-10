//
//  ReversiError.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 10.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum ReversiError: Error
{
    case positionTaken
    case incorrectDiskColor
    case noAdjacentDisks
    case noDisksToTurn
}
