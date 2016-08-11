//
//  RegistrationUserDetailViewController.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit
import Security

class RegistrationUserDetailViewController: UIViewController, NSXMLParserDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    
    var createUser: SOAPCreateUser?

    @IBOutlet weak var userAccountNumberRegistration: UITextField!
    @IBOutlet weak var userLastNameRegistration: UITextField!
    @IBOutlet weak var userFinalPaymentRegistration: UITextField!
    @IBAction func completeRegistrationButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createUser = SOAPCreateUser(parent: self)
        createUser?.createUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
