//
//  SOAPCreateUser.swift
//  EnergyWallet
//
//  Created by Diy2210 on 11.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import UIKit
import Security

class SOAPCreateUser: NSObject, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    //var currentElement = ""
    //var records = NSMutableArray()
    //var record: [String: String] = [:]
    var element = NSString()
    //var elements: [String: String] = [:]
    var user = NSMutableString()
    var w3value = NSMutableString()
    var parentView: UIViewController
    
    init(parent: UIViewController) {
        self.parentView = parent
    }
    
    func createUser()
    {
        let url = NSURL(string:"https://93.127.10.197:59960/entirex/xmlrt")
        let soapMessage =
            "<?xml version='1.0' encoding='UTF-8'?>" +
                "SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xmm='http://namespace.softwareag.com/entirex/xml/mapping' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/'>" +
                "SOAP-ENV:Header" +
                "/SOAP-ENV:Header" +
                "SOAP-ENV:Body" +
                "m:WSDLVEGA xmlns:m='urn:com-softwareag-entirex-rpc:CSS-BASE-WSDLVEGA'>" +
                "USER-ID>0000000100</USER-ID" +
                "FUNC>CreatUser</FUNC" +
                "FIRMA>106</FIRMA" +
                "REQBUFB64>PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiID8+4oCoPENyZWF0VXNlcj7igKggICAgPHRlbGVwaG9uPjAwMDAwMDAxMDA8L3RlbGVwaG9uPuKAqCAgICA8ZW1haWw+ZGl5MjIxMCsxQGdtYWlsLmNvbTwvZW1haWw+4oCoICAgIDxwYXNzd29yZD50ZXN0PC9wYXNzd29yZD7igKg8L0NyZWF0VXNlcj4KCg==</REQBUFB64" +
                "SIGNB64></SIGNB64" +
                "/m:WSDLVEGA" +
                "/SOAP-ENV:Body" +
        "/SOAP-ENV:Envelope"
        
        let request = NSMutableURLRequest(URL: url!)
        let msgLength = String(soapMessage.characters.count)
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // or false
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration(),
            delegate: URLPinning(),
            delegateQueue: nil)
        //.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print(error!.description)
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode < 400 {
                        self.parser = NSXMLParser(data: data!)
                        self.parser.delegate = self
                        // start XML parsing (see Parser methods)
                        self.parser.parse()
                    } else {
                        print("Error Code " + String(httpResponse.statusCode))
                    }
                }
            }
        })
        task.resume()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if (element as NSString).isEqualToString("USER-ID") {
            user = ""
        } else if (element as NSString).isEqualToString("W3VALUE") {
            w3value = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if (element as NSString).isEqualToString("USER-ID") {
            user.appendString(string)
        } else if (element as NSString).isEqualToString("W3VALUE") {
            w3value.appendString(string)
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    }
    
    // end of XML parsing
    func parserDidEndDocument(parser: NSXMLParser)
    {
        // print("Records: \(recCount), offset: \(recOffset), limit: \(recLimit)")
        let decodedData = NSData(base64EncodedString: w3value as String, options: NSDataBase64DecodingOptions(rawValue: 0))
        let decoderString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        print(decoderString)
    }
}