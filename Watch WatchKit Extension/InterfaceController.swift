//
//  InterfaceController.swift
//  Watch WatchKit Extension
//
//  Created by Greg McNutt on 5/31/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBAction func beach() {
    }
    @IBAction func mountains() {
    }
    @IBAction func sea() {
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
