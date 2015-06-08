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
        // Your code after the user authorizes application for
        // requested scopes.
    
        // Load new view controller with user identifying information
        // as the user is now successfully logged in.
        let delegate = GetProfileDelegate(parentController: parentController)
        
        AIMobileLib.getProfile(delegate)
    }
    
    @objc func requestDidFail(errorResponse: APIError) {
        let error = UIAlertView(title: "",
            message: "errorMessage:" + errorResponse.error.message,
            delegate: nil,
            cancelButtonTitle: "OK")
        error.show()
    }
}
