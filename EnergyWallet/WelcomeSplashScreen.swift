//
//  WelcomeSplashScreen.swift
//  Energy Wallet
//
//  Created by Diy2210 on 25.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class WelcomeSplashScreen: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        let phone = Settings.sharedInstance.phone
        let password = Settings.sharedInstance.password
        if phone.isEmpty || password.isEmpty {
            self.performSegueWithIdentifier("Autorization", sender: self)
        } else {
            self.performSegueWithIdentifier("MenuController", sender: self)
        }
    }
}
