//
//  ReportOffenseViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class ReportOffenseViewController: UIViewController {
    
    @IBOutlet weak var reportLocalityTF: UITextField!
    @IBOutlet weak var reportNameStreet: UITextField!
    @IBOutlet weak var reportHouseNumberTF: UITextField!
    @IBOutlet weak var reportHouseNumberDetailTF: UITextField!
    @IBOutlet weak var reportSpecificationTF: UITextField!
    
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
