//
//  IntroViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 10.09.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Login button color
        loginButton.layer.borderColor = UIColor(red: 0.21, green: 0.75, blue: 0.97, alpha: 1).cgColor
        loginButton.layer.cornerRadius = 4
        loginButton.layer.borderWidth = 1
        
        //Register button color
        registerButton.layer.borderColor = UIColor(red: 0.21, green: 0.75, blue: 0.97, alpha: 1).cgColor
        registerButton.layer.cornerRadius = 4
        registerButton.layer.borderWidth = 1
        
    }
}
