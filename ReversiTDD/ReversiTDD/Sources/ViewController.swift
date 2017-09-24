//
//  ViewController.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 03.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        test1()
        test2()
    }

    fileprivate func test1()
    {
        let input =
                "___**___" +
                "_o______" +
                "________" +
                "___o*___" +
                "___*o___" +
                "________" +
                "_**___o_" +
                "________"
        if let board = Board(ascii: input)
        {
            let output = board.output()
            print("input:\n\(input)")
            print("\n")
            print("output:\n\(output)")
        }
    }

    fileprivate func test2()
    {
        let input = [
            "___**___",
            "_o______",
            "________",
            "___o*___",
            "___*o___",
            "________",
            "_**___o_",
            "________"
        ].joined()
        if let board = Board(ascii: input)
        {
            let output = board.output(showCoordinates: true)
            print("input:\n\(input)")
            print("\n")
            print("output:\n\(output)")
        }
    }
}

