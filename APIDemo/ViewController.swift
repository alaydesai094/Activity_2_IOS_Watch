//
//  ViewController.swift
//  APIDemo
//
//  Created by Parrot on 2019-03-03.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    // MARK: Outlets
    @IBOutlet weak var outputLabel: UILabel!
    
    
    
    // MARK: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let URL = "https://httpbin.org/get"
        let URL = "https://jsonplaceholder.typicode.com/posts"
        
        Alamofire.request(URL).responseJSON {
            
            response in
            
            // TODO: Put your code in here
            // ------------------------------------------
            // 1. Convert the API response to a JSON object
            
            // -- check for errors
            let apiData = response.result.value
            if (apiData == nil) {
                print("Error when getting API data")
                return
            }
            // -- if no errors, then keep going
            
            print(apiData)
            
            
            // 2. Parse out the data you need (sunrise / sunset time)
            
            // example2 - parse an array of dictionaries
            
            // 2a. Convert the response to a JSON object
            let jsonResponse = JSON(apiData)
            
            print(jsonResponse)
            
            // 2b. Get the array out of the JSON object
            var responseArray = jsonResponse.arrayValue
            
            // 2c. Get the 3rd item in the array
            // item #3 = position 2
            var item = responseArray[2];
            print(item)
            
            // Output the "title" of the item in position #2
            self.outputLabel.text = item["title"].stringValue
            
         
//            // 2b. Get a key from the JSON object
//            let origin = jsonResponse["origin"]
//            let host = jsonResponse["headers"]["Host"]
//
//            // 2c. Output the value to screen
//            print("Your IP Address: \(origin)")
//            print("Host: \(host)")
//
//            // 3. Show the data in the user interface
//            self.outputLabel.text = "IP Address: \(origin)"
        }
    
    
        // Does your iPhone support "talking to a watch"?
        // If yes, then create the session
        // If no, then output error message
        
        if (WCSession.isSupported()) {
            print("PHONE: Phone supports WatchConnectivity!")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else {
            print("PHONE: Phone does not support WatchConnectivity")
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        // output a debug message to the terminal
        print("WATCH: Got a message!")
        print(message)
       
       let messageData = message["item"] as! String
        
        // update the message with a label
          self.outputLabel.text = messageData
        
    }

    
    // MARK: Actions
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("button pressed")
        
        // check if the watch is paired / accessible
        if (WCSession.default.isReachable) {
            // construct the message you want to send
            // the message is in dictionary
            
            let abc = [
                "item":"Nikad Benchod..!!"
            ]
            
      
            
            
            // send the message to the watch
            WCSession.default.sendMessage(abc, replyHandler: nil)
        }
        else {
            print("PHONE: Cannot find the watch")
        }
        
    }
    

}

