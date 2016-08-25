//
//  RegistrationUserDetailViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class RegistrationUserDetailViewController: MyBaseViewController, UITextFieldDelegate {

    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var AccountTF: UITextField!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var sumTF: UITextField!
    
    @IBAction func completeRegistrationButton(sender: AnyObject) {
        
        let account = AccountTF.text!
        let name = NameTF.text!
        let payment = sumTF.text!
        
        let urlPath = Settings.sharedInstance.serverURL + Settings.sharedInstance.createAccountURI
        let params = "phone=\(Settings.sharedInstance.phone.URLEncodedString()!)&password=\(Settings.sharedInstance.password.URLEncodedString()!)&account=\(account.URLEncodedString()!)&name=\(name.URLEncodedString()!)&sum=\(payment)"
        
        let task = self.sendRequest(urlPath, parameters: params, phone:  Settings.sharedInstance.phone, password:  Settings.sharedInstance.password, segue: "endRegistration")
        
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
