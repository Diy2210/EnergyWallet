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
        let request = self.buildRequest(url: urlPath, parameters: params)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else { return }
            
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse!.statusCode < 400 else {
                print("statusCode: \(httpResponse!.statusCode)")
                return
            }
            
            var json: NSDictionary?
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? NSDictionary
            } catch {
                DispatchQueue.main.async {
                    self.messageNotification(message: "Could not parse JSON")
                    return
                }
            }
            if let parseJSON = json {
                let success = parseJSON["success"] as? Bool
                if success == true {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "endRegistration", sender: self)
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        self.messageNotification(message: parseJSON["message"] as! String)
                        return
                    }
                }
            }
        })
        
        task.resume()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , with:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
