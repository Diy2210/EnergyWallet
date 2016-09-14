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
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0]
        self.path = (documentsDirectory as AnyObject).appendingPathComponent("Settings.plist")
        
        let fileManager = FileManager.default
        
        // check if file exists
        if !fileManager.fileExists(atPath: self.path) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = Bundle.main.path(forResource: "Settings", ofType: "plist") {
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: self.path)
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
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Create user
    var createUserURI: String {
        get {
            return settings["CreateUserURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateUserURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Login user
    var loginUserURI: String {
        get {
            return settings["LoginUserURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "LoginUserURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get region
    var getRegionURI: String {
        get {
            return settings["GetRegionURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetRegionURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get street
    var getStreetURI: String {
        get {
            return settings["GetStreetURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetStreetURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get statistics
    var getStatisticsURI: String {
        get {
            return settings["GetStatisticsURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetStatisticsURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get blackout city
    var getBlackoutCityURI: String {
        get {
            return settings["GetBlackoutCityURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetBlackoutCityURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get blackout street
    var getBlackoutStreetURI: String {
        get {
            return settings["GetBlackoutStreetURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetBlackoutStreetURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get blackout adress
    var getBlackoutAdressURI: String {
        get {
            return settings["GetBlackoutAdress"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetBlackoutAdress")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Create account
    var createAccountURI: String {
        get {
            return settings["CreateAccountURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateAccountURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Create account adress
    var createAccountAdressURI: String {
        get {
            return settings["CreateAccountAdressURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "CreateAccountAdressURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Get adress list
    var getAdressListURI: String {
        get {
            return settings["GetAdressListURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "GetAdressListURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Delete account adress
    var deleteAccountAdressURI: String {
        get {
            return settings["DeleteAccountAdressURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "DeleteAccountAdressURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Reports alarm
    var reportsAlarmURI: String {
        get {
            return settings["ReportsAlarmsURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "ReportsAlarmsURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Reports complain
    var reportsComplainURI: String {
        get {
            return settings["ReportsComplainURI"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "ReportsComplainURI")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Phone user
    var phone: String {
        get {
            return settings["phone"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "phone")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Email user
    var email: String {
        get {
            return settings["email"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "email")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Password user
    var password: String {
        get {
            return settings["password"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "password")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Region user
    var region: String {
        get {
            return settings["region"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "region")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Street user
    var street: String {
        get {
            return settings["street"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "street")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // City user
    var city: String {
        get {
            return settings["city"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "city")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Number user
    var number: String {
        get {
            return settings["number"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "number")
            settings.write(toFile: path, atomically: false)
        }
    }
    
    // Date
    var date: String {
        get {
            return settings["date"] as! String
        }
        set(newValue) {
            settings.setValue(newValue, forKey: "date")
            settings.write(toFile: path, atomically: false)
        }
    }
}

