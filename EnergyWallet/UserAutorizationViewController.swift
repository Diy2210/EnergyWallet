//
//  UserAutorizationViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class UserAutorizationViewController: MyBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func loginUserCompleteButton(sender: AnyObject) {
        
        let phone = userPhone.text!
        let password = userPassword.text!
        
        if phone.isEmpty || password.isEmpty {
            self.messageNotification("Неверный телефон или пароль. Пожалуйста, проверьте введенные данные и исправьте ошибки")
            
            return
        }
        
        let urlPath = Settings.sharedInstance.serverURL + Settings.sharedInstance.loginUserURI
        let params = "phone=\(phone.URLEncodedString()!)&password=\(password.URLEncodedString()!)"
        
        let task = self.sendRequest(urlPath, parameters: params, phone: phone, password: password, segue: "login")
        task.resume()
    }


    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0,250), animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        ScrollView.setContentOffset(CGPointMake(0,0), animated: true)
    }
}
