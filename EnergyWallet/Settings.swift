//
//  Settings.swift
//  Energy Wallet
//
//  Created by Diy2210 on 26.07.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import Foundation

class Settings {
    
    class var sharedInstance: Settings {
        struct Singleton {
            static let instance = Settings()
        }
        return Singleton.instance
    }
    
    internal var settings: NSMutableDictionary!
    internal var path: String!
    
    required init() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0]
        self.path = documentsDirectory.stringByAppendingPathComponent("Settings.plist")
        
        let fileManager = NSFileManager.defaultManager()
        
        // check if file exists
        if !fileManager.fileExistsAtPath(self.path) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("Settings", ofType: "plist") {
                do {
                    try fileManager.copyItemAtPath(bundlePath, toPath: self.path)
                } catch {
                    print("Something wrong while copiying plist file")
                }
            } else {
                print("Settings.plist not found. Please, make sure it is part of the bundle.")
            }
        }
        self.settings = NSMutableDictionary(contentsOfFile:self.path)
    }
    
    // Server URI
    var serverURL: String {
        get {
            return settings["EneryWalletEndPoint"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "EneryWalletEndPoint")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var createUserURI: String {
        get {
            return settings["CreateUserURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateUserURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var loginUserURI: String {
        get {
            return settings["LoginUserURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "LoginUserURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var getRegionURI: String {
        get {
            return settings["GetRegionURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetRegionURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var getStreetURI: String {
        get {
            return settings["GetStreetURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetStreetURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var phone: String {
        get {
            return settings["phone"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "phone")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var email: String {
        get {
            return settings["email"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "email")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var password: String {
        get {
            return settings["password"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "password")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var region: String {
        get {
            return settings["region"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "region")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var street: String {
        get {
            return settings["street"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "street")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var city: String {
        get {
            return settings["city"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "city")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var number: String {
        get {
            return settings["number"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "number")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    var date: String {
        get {
            return settings["date"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "date")
            settings.writeToFile(path, atomically: false)
        }
    }
}

