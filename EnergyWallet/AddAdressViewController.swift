//
//  AddAdressViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class AddAdressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameAdressTF: UITextField!
    @IBOutlet weak var localityTF: UITextField!
    @IBOutlet weak var nameStreet: UITextField!
    @IBOutlet weak var houseNumberTF: UITextField!
    @IBOutlet weak var houseNumberDetailTF: UITextField!
    @IBOutlet weak var theSwitch: UISwitch!
    @IBOutlet weak var notificationLabel: UILabel!
    
    // Switch button
    @IBAction func swithButton(_ sender: AnyObject) {
        if theSwitch.isOn {
            notificationLabel.text = "Уведомлять об отключениях"
        }else{
            notificationLabel.text = "Не уведомлять об отключениях"
        }
    }
    
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
    
    // Add button
    @IBAction func addButton(_ sender: AnyObject) {
  }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , with:event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
