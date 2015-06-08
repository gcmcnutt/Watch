//
//  LogoutDelegate.swift
//  Watch
//
//  Created by Greg McNutt on 6/7/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import Foundation

class LogoutDelegate: NSObject, AIAuthenticationDelegate {
    let parentController: ViewController
    
    init(parentController: ViewController) {
        self.parentController = parentController
    }
    
    
    @objc func requestDidSucceed(apiResult: APIResult!) {
        // Your additional logic after the user authorization state is cleared.
        parentController.nameField.text = ""
        parentController.emailField.text = ""
        parentController.idField.text = ""
        parentController.postalField.text = ""

        let alert = UIAlertView(title: "",
            message: "User Logged out.",
            delegate: nil,
            cancelButtonTitle: "OK")
        alert.show()
   }
    
    @objc func requestDidFail(errorResponse: APIError) {
        let error = UIAlertView(title: "",
            message: "errorMessage:" + errorResponse.error.message,
            delegate: nil,
            cancelButtonTitle: "OK")
        error.show()
    }
}