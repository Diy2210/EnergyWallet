//
//  RegistrationUserViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class RegistrationUserViewController: MyBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userPhoneRegistration: UITextField!
    @IBOutlet weak var userEmailRegistration: UITextField!
    @IBOutlet weak var userPasswordRegistration: UITextField!
    
    @IBAction func completeNextButton(sender: AnyObject) {
        view.endEditing(true)
        
        let phone = userPhoneRegistration.text!
        let email = userEmailRegistration.text!
        let password = userPasswordRegistration.text!
        
        if phone.isEmpty || email.isEmpty || password.isEmpty {
            self.messageNotification("Пожалуйста, проверьте введенные данные. Одно из полей не заполнено")
            
            return
        }
        
        let urlPath = Settings.sharedInstance.serverURL + Settings.sharedInstance.createUserURI
        let params = "phone=\(phone.URLEncodedString()!)&email=\(email.URLEncodedString()!)&password=\(password.URLEncodedString()!)"
        
        let request = self.buildRequest(urlPath, parameters: params)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            guard error == nil else { return }
            
            let httpResponse = response as? NSHTTPURLResponse
            guard httpResponse!.statusCode < 400 else {
                print("statusCode: \(httpResponse!.statusCode)")
                return
            }
            
            var json: NSDictionary?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary
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
                        self.performSegueWithIdentifier("createUser", sender: self)
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
        
        task.resume()
     }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
