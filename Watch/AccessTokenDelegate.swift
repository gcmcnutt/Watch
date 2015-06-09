//
//  AccessTokenDelegate.swift
//  Watch
//
//  Created by Greg McNutt on 6/7/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import Foundation

class AccessTokenDelegate: NSObject, AIAuthenticationDelegate {
    
    @objc func requestDidSucceed(apiResult: APIResult!) {
        let token = apiResult.result as! String
        
        var credentialsProvider = AWSServiceManager.defaultServiceManager().defaultServiceConfiguration.credentialsProvider as! AWSCognitoCredentialsProvider
        credentialsProvider.logins = [ "www.amazon.com": token ]
    }
 

    @objc func requestDidFail(errorResponse: APIError) {
        let error = UIAlertView(title: "",
            message: "errorMessage:" + errorResponse.error.message,
            delegate: nil,
            cancelButtonTitle: "OK")
        error.show()
    }
}
