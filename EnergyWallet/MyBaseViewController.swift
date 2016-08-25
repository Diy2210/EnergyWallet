//
//  MyBaseViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 24.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class MyBaseViewController: UIViewController {

    var lastResponse: NSMutableDictionary = [:]
    
    // Messege notification
    func messageNotification(message: String, title: String = "Ошибка") -> Void {
        let AlertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        AlertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(AlertView, animated: true, completion: nil)
    }
    
    // Build request
    func buildRequest(url: String, parameters: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        return request
    }
    
    // Send request
    func sendRequest(urlPath: String, parameters: String, phone: String, password: String, segue: String) -> NSURLSessionDataTask {
        // reset lastResponse
        self.lastResponse = [:]
        let request = self.buildRequest(urlPath, parameters: parameters)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            guard error == nil else { return }
            
            let httpResponse = response as? NSHTTPURLResponse
            guard httpResponse!.statusCode < 400 else {
                if httpResponse!.statusCode == 401 {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("Autorization", sender: self)
                        return
                    })
                }
                return
            }
            
            var json: NSDictionary?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch {
                dispatch_async(dispatch_get_main_queue(), {
                    self.messageNotification("Could not parse JSON")
                    return
                })
            }
            if let parseJSON = json {
                let success = parseJSON["success"] as? Bool
                if success == true {
                    // save it for later use
                    self.lastResponse = parseJSON as! NSMutableDictionary
                    if (!phone.isEmpty && !password.isEmpty) {
                        // save phone & password into Settings
                        Settings.sharedInstance.phone = phone
                        Settings.sharedInstance.password = password
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier(segue, sender: self)
                        return
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.messageNotification(parseJSON["message"] as! String)
                        return
                    })
                }
            }
        })
        return task
    }
}

extension String {
    func URLEncodedString() -> String? {
        let customAllowedSet = NSCharacterSet(charactersInString:"=+\"#%/<>?@\\^`{|}").invertedSet
        let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString
    }
}
