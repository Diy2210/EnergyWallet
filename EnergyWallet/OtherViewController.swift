//
//  OtherViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 23.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController, UITextFieldDelegate {

    override func viewDidAppear(_ animated: Bool) {
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.default
        navigationBar?.tintColor = UIColor.black
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
}
