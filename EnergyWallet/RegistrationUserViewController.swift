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
        let params = "phone=\(phone)&email=\(email)&password=\(password)"
        
        if phone.isEmpty || email.isEmpty || password.isEmpty {
            self.messageNotification("Пожалуйста, проверте введенные данные")
            return
        }
        
        request.HTTPMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            // handle error
            guard error == nil else { return }
            var json: NSDictionary?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch {
                print("Complete")
                return
            }
            if let parseJSON = json {
                let success = parseJSON["success"] as? Int
                self.performSegueWithIdentifier("create", sender: self)
                print("Success: \(success)")
                print(parseJSON)
            }
            else {
                
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: \(jsonStr)")
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
