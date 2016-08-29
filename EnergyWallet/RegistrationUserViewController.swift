//
//  RegistrationUserViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class RegistrationUserViewController: MyBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var userPhoneRegistration: UITextField!
    @IBOutlet weak var userEmailRegistration: UITextField!
    @IBOutlet weak var userPasswordRegistration: UITextField!
    
    @IBAction func completeNextButton(sender: AnyObject) {
        
        let phone = userPhoneRegistration.text!
        let email = userEmailRegistration.text!
        let password = userPasswordRegistration.text!
        
        if phone.isEmpty || email.isEmpty || password.isEmpty {
            self.messageNotification("Пожалуйста, проверьте введенные данные. Одно из полей не заполнено")
            
            return
        }
        
        let urlPath = Settings.sharedInstance.serverURL + Settings.sharedInstance.createUserURI
        let params = "phone=\(phone.URLEncodedString()!)&email=\(email.URLEncodedString()!)&password=\(password.URLEncodedString()!)"
        
        let task = self.sendRequest(urlPath, parameters: params, phone: phone, password: password, segue: "createUser")
        
        task.resume()
        
    }
    
        func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0,220), animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0,0), animated: true)
    }
}
