//
//  MyBaseViewController.swift
//  EnergyWallet
//
//  Created by Diy2210 on 24.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit

class MyBaseViewController: UIViewController {

    var lastResponse: NSMutableDictionary = [:]
    var activityIndicator: UIActivityIndicatorView!
    
    // Activity Indicator Function
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    
    // Messege notification
    func messageNotification(message: String, title: String = "Ошибка") -> Void {
        let AlertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        AlertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(AlertView, animated: true, completion: nil)
    }
    
    // Build request
    func buildRequest(url: String, parameters: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = parameters.data(using: .utf8)
        addActivityIndicator()
        return request
    }
    
    // Send request
    func sendRequest(urlPath: String, parameters: String, phone: String, password: String, segue: String) -> URLSessionDataTask {
        // reset lastResponse
        self.lastResponse = [:]
        let request = self.buildRequest(url: urlPath, parameters: parameters)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else { return }
            
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse!.statusCode < 400 else {
                if httpResponse!.statusCode == 401 {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "Autorization", sender: self)
                        return
                    }
                }
                return
            }
            
            var json: NSDictionary?
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? NSDictionary
            } catch {
                DispatchQueue.main.async {
                    self.messageNotification(message: "Could not parse JSON")
                    return
                }
            }
            if let parseJSON = json {
                let success = parseJSON["success"] as? Bool
                if success == true {
                    // save it for later use
                    self.lastResponse = parseJSON as! NSMutableDictionary
                    if (!phone.isEmpty && !password.isEmpty) {
                        // save phone & password into Settings
                        Settings.sharedInstance.phone = phone
                        Settings.sharedInstance.password = password
                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: segue, sender: self)
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        self.messageNotification(message: parseJSON["message"] as! String)
                        return
                    }
                }
            }
        })
       
        return task
    }
}

extension String {
    func URLEncodedString() -> String? {
        let customAllowedSet = NSCharacterSet(charactersIn:"=+\"#%/<>?@\\^`{|}").inverted
        //let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        let urlwithPercentEscapes = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlwithPercentEscapes
    }
}

