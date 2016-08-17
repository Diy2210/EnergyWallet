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
        let params = "phone=\(phone)&password=\(password)"
        
        if phone.isEmpty || password.isEmpty {
            self.messageNotification("Неверный логин или пароль. Пожалуйста, проверте введенные данные и исправьте ошибки")
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
                print("Could not parse JSON")
                return
            }
            if let parseJSON = json {
                let success = parseJSON["success"] as? Int
                self.performSegueWithIdentifier("login", sender: self)
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
