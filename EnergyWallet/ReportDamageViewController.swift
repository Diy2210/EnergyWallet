//
//  ReportDamageViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class ReportDamageViewController: UIViewController {

    @IBOutlet weak var damageLocalityTF: UITextField!
    @IBOutlet weak var damageNameStreetTF: UITextField!
    @IBOutlet weak var damageHouseNumberTF: UITextField!
    @IBOutlet weak var damageHouseNumberDetailTF: UITextField!
    @IBOutlet weak var damageSpecificationTF: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.Default
        navigationBar?.tintColor = UIColor.blackColor()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    @IBAction func sendCompleteButton(sender: AnyObject) {
    }
}
