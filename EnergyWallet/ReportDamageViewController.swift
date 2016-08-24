//
//  ReportDamageViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 19.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class ReportDamageViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var damageLocalityTF: UITextField!
    @IBOutlet weak var damageNameStreetTF: UITextField!
    @IBOutlet weak var damageHouseNumberTF: UITextField!
    @IBOutlet weak var damageHouseNumberDetailTF: UITextField!
    
    @IBOutlet weak var damageSpecification: UILabel!
    @IBOutlet weak var damageList: UIPickerView!
    
    let pickerData = ["Вариант 1","Вариант 2","Вариант 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        damageList.dataSource = self
        damageList.delegate = self
    }
    
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        damageSpecification.text = pickerData[row]
    }
    
    @IBAction func sendCompleteButton(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
