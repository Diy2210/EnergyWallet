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
    
    // Create user
    var createUserURI: String {
        get {
            return settings["CreateUserURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateUserURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Login user
    var loginUserURI: String {
        get {
            return settings["LoginUserURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "LoginUserURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Get region
    var getRegionURI: String {
        get {
            return settings["GetRegionURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetRegionURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Get street
    var getStreetURI: String {
        get {
            return settings["GetStreetURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetStreetURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Get statistics
    var getStatisticsURI: String {
        get {
            return settings["GetStatisticsURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetStatisticsURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Get blackout city
    var getBlackoutCityURI: String {
        get {
            return settings["GetBlackoutCityURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetBlackoutCityURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Get blackout street
    var getBlackoutStreetURI: String {
        get {
            return settings["GetBlackoutStreetURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetBlackoutStreetURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Get blackout adress
    var getBlackoutAdressURI: String {
        get {
            return settings["GetBlackoutAdress"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetBlackoutAdress")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Create account
    var createAccountURI: String {
        get {
            return settings["CreateAccountURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateAccountURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Create account adress
    var createAccountAdressURI: String {
        get {
            return settings["CreateAccountAdressURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateAccountAdressURI")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Phone user
    var phone: String {
        get {
            return settings["phone"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "phone")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Email user
    var email: String {
        get {
            return settings["email"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "email")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Password user
    var password: String {
        get {
            return settings["password"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "password")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Region user
    var region: String {
        get {
            return settings["region"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "region")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Street user
    var street: String {
        get {
            return settings["street"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "street")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // City user
    var city: String {
        get {
            return settings["city"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "city")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Number user
    var number: String {
        get {
            return settings["number"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "number")
            settings.writeToFile(path, atomically: false)
        }
    }
    
    // Date
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

