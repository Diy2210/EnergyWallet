//
//  AddCounterViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class AddCounterViewController: MyBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var AccountTF: UITextField!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var sumTF: UITextField!
    
    @IBAction func addButton(sender: AnyObject) {
        view.endEditing(true)
        
        let account = AccountTF.text!
        let lastName = NameTF.text!
        let payment = sumTF.text!
        
        let urlPath = Settings.sharedInstance.serverURL + Settings.sharedInstance.createAccountURI
        let params = "phone=\(Settings.sharedInstance.phone.URLEncodedString()!)&password=\(Settings.sharedInstance.password.URLEncodedString()!)&account=\(account.URLEncodedString()!)&name=\(lastName.URLEncodedString()!)&sum=\(payment)"
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
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("endRegistration", sender: self)
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
