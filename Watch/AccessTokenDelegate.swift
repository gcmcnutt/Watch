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
        let dict = apiResult.result as? NSDictionary
        
            
            // in iOS Amazon calls the requestDidSucceed method in your
            // AMZNAccessTokenDelegate implementation
            //- (void)requestDidSucceed:(APIResult *)apiResult {
            //    credentialsProvider.logins = @{ AWSCognitoLoginProviderKeyLoginWithAmazon:apiResult.result);
    }
    
    @objc func requestDidFail(errorResponse: APIError) {
        let error = UIAlertView(title: "",
            message: "errorMessage:" + errorResponse.error.message,
            delegate: nil,
            cancelButtonTitle: "OK")
        error.show()
    }
}
