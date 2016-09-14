//
//  PasswordRecoveryViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class PasswordRecoveryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var userRecoveryPassword: UITextField!
    
    @IBAction func recoveryPasswordButton(_ sender: AnyObject) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0,y: 180), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        ScrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
}
