//
//  ConsoleIO.swift
//  ReversiConsole
//
//  Created by Pawel Leszkiewicz on 03.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum OutputType
{
    case error
    case standard
}

class ConsoleIO
{
    func writeMessage(_ message: String, to: OutputType = .standard)
    {
        switch to
        {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }

    func writeError(_ error: String)
    {
        writeMessage(error, to: .error)
    }

    func getInput() -> String
    {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}
