//
//  URLPinning.swift
//  EnergyWallet
//
//  Created by Diy2210 on 11.08.16.
//  Copyright © 2016 Diy2210. All rights reserved.
//

import Foundation
import Security

class URLPinning: NSObject, NSURLSessionDelegate {
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType(kSecTrustResultInvalid)
                let status = SecTrustEvaluate(serverTrust, &secresult)
                
                if(errSecSuccess == status) {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        if let serverCertificateData = SecCertificateCopyData(serverCertificate) as? CFDataRef {
                            let data = CFDataGetBytePtr(serverCertificateData);
                            let size = CFDataGetLength(serverCertificateData);
                            let cert1 = NSData(bytes: data, length: size)
                            let file_der = NSBundle.mainBundle().pathForResource("mobikassa.der", ofType: "der")
                            if let file = file_der {
                                if let cert2 = NSData(contentsOfFile: file) {
                                    if cert1.isEqualToData(cert2) {
                                        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, NSURLCredential(forTrust:serverTrust))
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        // Pinning failed
        completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
    }
    
    
}
