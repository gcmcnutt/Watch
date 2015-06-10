//
//  AuthorizeUserDelegate.swift
//  Watch
//
//  Created by Greg McNutt on 6/6/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import Foundation

class AuthorizeUserDelegate: NSObject, AIAuthenticationDelegate {
    let parentController: ViewController
    
    init(parentController: ViewController) {
        self.parentController = parentController
    }
    
    @objc func requestDidSucceed(apiResult: APIResult!) {
        launchGetAccessToken()
    }
    
    @objc func requestDidFail(errorResponse: APIError) {
        let error = UIAlertView(title: "",
            message: "AuthorizeUser:" + errorResponse.error.message,
            delegate: nil,
            cancelButtonTitle: "OK")
        error.show()
    }
    
    func launchGetAccessToken() {
        // initialize the token system
        let delegate = AccessTokenDelegate(parentController: parentController)
        var requestScopes: [String] = ["profile", "postal_code"]
        AIMobileLib.getAccessTokenForScopes(requestScopes, withOverrideParams: nil, delegate: delegate)

    }
}
