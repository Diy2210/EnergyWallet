//
//  UserAutorizationViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class UserAutorizationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func loginUserCompleteButton(sender: AnyObject) {
        
        let session = NSURLSession.sharedSession()
        let urlPath = NSURL(string: "http://192.168.0.100:8080/api/login")
        let request = NSMutableURLRequest(URL: urlPath!)
        let phone = userPhone.text!
        let password = userPassword.text!
        
        if phone.isEmpty || password.isEmpty {
            self.messageNotification("Неверный телефон или пароль. Пожалуйста, проверьте введенные данные и исправьте ошибки")
            
            return
        }
        
        let params = "phone=\(phone)&password=\(password)"
        request.HTTPMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            guard error == nil else { return }
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
                    // save phone & password into Settings
                    Settings.sharedInstance.phone = phone
                    Settings.sharedInstance.password = password
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("login", sender: self)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.messageNotification("Телефон или пароль указан неверно. Пожалуйста, проверьте введенные данные.")
                    })
                    return
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.messageNotification("Could not parse response")
                    return
                })
            }
        })
        
        task.resume()
    }
    
    private func messageNotification(message: String, title: String = "Ошибка") -> Void {
        let AlertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        AlertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(AlertView, animated: true, completion: nil)
    }
}
