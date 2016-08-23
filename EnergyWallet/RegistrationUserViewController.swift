//
//  RegistrationUserViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class RegistrationUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userPhoneRegistration: UITextField!
    @IBOutlet weak var userEmailRegistration: UITextField!
    @IBOutlet weak var userPasswordRegistration: UITextField!
    
    @IBAction func completeNextButton(sender: AnyObject) {
        
        let session = NSURLSession.sharedSession()
        let urlPath = NSURL(string: "http://192.168.0.100:8080/api/user")
        let request = NSMutableURLRequest(URL: urlPath!)
        let phone = userPhoneRegistration.text!
        let email = userEmailRegistration.text!
        let password = userPasswordRegistration.text!
        
        if phone.isEmpty || email.isEmpty || password.isEmpty {
           // self.messageNotificationError("Пожалуйста, проверте введенные данные. Одно из полей не заполнено.")
        
            let alertController = UIAlertController(title: "Ошибка", message: "Пожалуйста, проверте введенные данные. Одно из полей не заполнено", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        let params = "phone=\(phone)&email=\(email)&password=\(password)"
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
                   //
                    let alertController = UIAlertController(title: "Error", message: "Could not parse JSON", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                print("Complete! User create")
                    
                return
              })
            }
            if let parseJSON = json {
                let success = parseJSON["success"] as? Bool
                if success == true {
                    // save phone & password into Settings
                    // Settings.sharedInstance.phone = phone
                    // Settings.sharedInstance.password = email
                    // Settings.sharedInstance.password = password
                     dispatch_async(dispatch_get_main_queue(), {
                         self.performSegueWithIdentifier("createUser", sender: self)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                      //  self.messageNotificationError("Пользователь с такими данными уже зарегистрирован")
                        let alertController = UIAlertController(title: "Ошибка", message: "Пользователь с такими данными уже зарегистрирован", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                    return
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                  //  self.messageNotificationError("Could not parse response")
                  //
                    let alertController = UIAlertController(title: "Error", message: "Could not parse response", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return
                })
            }
        })
        
        task.resume()
    }
    
   // private func messageNotificationError(message: String, title: String = "Ошибка") -> Void {
   //     let AlertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
   //     AlertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
   //     self.presentViewController(AlertView, animated: true, completion: nil)
   // }
}
