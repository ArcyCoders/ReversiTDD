//
//  AppDelegate.swift
//  ReversiWindow
//
//  Created by Pawel Leszkiewicz on 08.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        window.acceptsMouseMovedEvents = true
        window.contentViewController = ReversiViewController()
    }
}
