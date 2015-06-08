//
//  GetProfileDelegate.swift
//  Watch
//
//  Created by Greg McNutt on 6/6/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import Foundation
import UIKit

class GetProfileDelegate: NSObject, AIAuthenticationDelegate {
    let parentController: ViewController
    
    init(parentController: ViewController) {
        self.parentController = parentController
    }
    
    @objc func requestDidSucceed(apiResult: APIResult!) {
        // Get profile request succeded. Unpack the profile information
        // and pass it to the parent view controller
        
        let dict = apiResult.result as? NSDictionary
        let name = dict!.valueForKey("name") as! String
        let email = dict!.valueForKey("email") as! String
        let userId = dict!.valueForKey("user_id") as! String
        let postal_code = dict!.valueForKey("postal_code") as! String
        
        // Pass data to view controller!
        var requestScopes: [String] = ["profile", "postal_code"]
        let delegate = AccessTokenDelegate()

        AIMobileLib.getAccessTokenForScopes(requestScopes, withOverrideParams: nil, delegate: delegate)
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