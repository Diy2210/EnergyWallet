//
//  OtherViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 23.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController, UITextFieldDelegate {

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
    
    // Search button
    @IBAction func searchButton(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Поиск по адресу", message: "В разработке...", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Search bar button
    @IBAction func searchBarButton(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Поиск по адресу", message: "В разработке...", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
