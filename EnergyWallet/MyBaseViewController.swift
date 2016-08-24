//
//  MyBaseViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 24.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class MyBaseViewController: UIViewController {

    func messageNotification(message: String, title: String = "Ошибка") -> Void {
        let AlertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        AlertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(AlertView, animated: true, completion: nil)
    }
    
    func buildRequest(url: String, parameters: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        return request
    }
}

extension String {
    func URLEncodedString() -> String? {
        let customAllowedSet = NSCharacterSet(charactersInString:"=+\"#%/<>?@\\^`{|}").invertedSet
        let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString
    }
}
