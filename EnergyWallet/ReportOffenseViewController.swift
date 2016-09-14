//
//  ReportOffenseViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class ReportOffenseViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var reportLocalityTF: UITextField!
    @IBOutlet weak var reportNameStreet: UITextField!
    @IBOutlet weak var reportHouseNumberTF: UITextField!
    @IBOutlet weak var reportHouseNumberDetailTF: UITextField!
    @IBOutlet weak var reportSpecificationTF: UITextField!
    
    @IBAction func sendCompleteButton(_ sender: AnyObject) {
        view.endEditing(true)
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
