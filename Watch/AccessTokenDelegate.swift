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
        // Get Profile request failed for profile scope.
        
        // If error code = kAIApplicationNotAuthorized,
        // allow user to log in again.
        if (errorResponse.error.code == kAIApplicationNotAuthorized) {
            // Show authorize user button.
            //parentController.showLoginPage()
        }
        else {
            // Handle other errors
            let error = UIAlertView(title: "",
                message: "errorMessage:" + errorResponse.error.message,
                delegate: nil,
                cancelButtonTitle: "OK")
            error.show()
        }
    }
}
