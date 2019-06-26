//
//  Page1InterfaceController.swift
//  APIDemo WatchKit Extension
//
//  Created by MacStudent on 2019-06-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class Page1InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    
    // MARK: Required function for WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        // output a debug message to the terminal
        print("WATCH: Got a message!")
        print(message)
        /*
         
         message = {
         "lastname":"cat",
         "firstname":"blue"
         "email":
         "lat":
         "lng"
         "username":
         "password":
         }
        */
        self.personDataList = [
            message["item"] as! String
        ]
        
        // 1. Tell watch how many rows you want
        self.tableViewThing.setNumberOfRows(
            self.personDataList.count, withRowType:"myRow"
        )
        
        // 2. Tell watch what data goes in each row
        for (index, data) in self.personDataList.enumerated() {
            let row = self.tableViewThing.rowController(at: index) as! RowController
            row.outputLabel.setText(data)
        }
        
    
        // update the message with a label
        self.phoneMessageLabel.setText("\(message)")
    }
    
    
    // MARK: Outlets
    // ----------
    //outlet for the table
    @IBOutlet var tableViewThing: WKInterfaceTable!
    
    // outlet for label to hold messages from phone
    @IBOutlet var phoneMessageLabel: WKInterfaceLabel!
    
    
    // MARK: Data source
    var personDataList = [
        "Alay",
        "Dhyanee",
        "Saloni",
        "Shivam",
        "Raja",
        "Vasu bhabhi"
    ]
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    
    @IBAction func sendDataBtn() {
        
        if WCSession.isSupported() {
            
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
            if WCSession.default.isReachable {
                
                
                let data = [
                    "item":"Tara Baap ne k j"
                ]
                
                
                session.sendMessage(data, replyHandler: {(_ replyMessage: [String: Any]) -> Void in
                    
                    print("ReplyHandler called = \(replyMessage)")
                    WKInterfaceDevice.current().play(WKHapticType.notification)
                },
                                      errorHandler: {(_ error: Error) -> Void in
                                        
                                        print("Error = \(error.localizedDescription)")
                })
            }
        }
        
    }
    
    
    
    
    
    
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        // check for wcsession
        if (WCSession.isSupported()) {
            print("WATCH: WCSession is supported!")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else {
            print("WATCH: Does not support WCSession, sorry!")
        }
        
        
        // 1. Tell watch how many rows you want
        self.tableViewThing.setNumberOfRows(
            self.personDataList.count, withRowType:"myRow"
        )
        
        // 2. Tell watch what data goes in each row
        for (index, data) in self.personDataList.enumerated() {
            let row = self.tableViewThing.rowController(at: index) as! RowController
            row.outputLabel.setText(data)
        }
        
        
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
