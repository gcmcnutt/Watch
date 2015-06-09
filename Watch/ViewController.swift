//
//  ViewController.swift
//  Watch
//
//  Created by Greg McNutt on 5/31/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var photoFrame: [UIImageView]!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var idField: UILabel!
    @IBOutlet weak var postalField: UILabel!
    
    @IBAction func fetchS3(sender: AnyObject) {
        let key = "DSCF3169.png"
        let bucket = "watchtest.accelero.com"
        
        let downloadFilePath = NSTemporaryDirectory().stringByAppendingPathComponent(key)
        let downloadingFileURL = NSURL.fileURLWithPath(downloadFilePath)
                
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        downloadRequest.bucket = bucket
        downloadRequest.key  = key
        downloadRequest.downloadingFileURL = downloadingFileURL
        
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        transferManager.download(downloadRequest).continueWithBlock {
            (task: BFTask!) -> AnyObject! in
            if task.error != nil {
                let error = UIAlertView(title: "",
                    message: "errorMessage:" + task.error.description,
                    delegate: nil,
                    cancelButtonTitle: "OK")
                error.show()
            }
            else {
                // Set the UIImageView to show the file that was downloaded
                let image = UIImage(contentsOfFile: downloadFilePath)
                
                self.photoFrame[0].image = image
            }
            
            return nil
        } // end closure
    }
    
    @IBAction func amznLogin(sender: AnyObject) {
        // Make authorize call to SDK to get secure access token for the user.
        // While making the first call you can specify the minimum basic
        // scopes needed.
        
        // Requesting both scopes for the current user.
        var requestScopes: [String] = ["profile", "postal_code"]
        let delegate = AuthorizeUserDelegate(parentController: self)
        AIMobileLib.authorizeUserForScopes(requestScopes, delegate: delegate)
    }
    
    @IBAction func amznLogout(sender: AnyObject) {
        let delegate = LogoutDelegate(parentController: self)
        
        AIMobileLib.clearAuthorizationState(delegate)
    }

}

