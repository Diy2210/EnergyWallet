//
//  RegistrationUserDetailViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class RegistrationUserDetailViewController: UIViewController {

    @IBOutlet weak var userAccountNumberRegistration: UITextField!
    @IBOutlet weak var userLastNameRegistration: UITextField!
    @IBOutlet weak var userFinalPaymentRegistration: UITextField!
    @IBAction func completeRegistrationButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}