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
    
    @IBAction func loginUserCompleteButton(_ sender: AnyObject) {
        
        let phone = userPhone.text!
        let password = userPassword.text!
        
        if phone.isEmpty || password.isEmpty {
            self.messageNotification(message: "Неверный телефон или пароль. Пожалуйста, проверьте введенные данные и исправьте ошибки")
            
            return
        }
        
        let urlPath = Settings.sharedInstance.serverURL + Settings.sharedInstance.loginUserURI
        let params = "phone=\(phone.URLEncodedString()!)&password=\(password.URLEncodedString()!)"
        
        let task = self.sendRequest(urlPath: urlPath, parameters: params, phone: phone, password: password, segue: "login")

        task.resume()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0,y: 230), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
}
