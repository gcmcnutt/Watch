//
//  ViewController.swift
//  Watch
//
//  Created by Greg McNutt on 5/31/15.
//  Copyright (c) 2015 Greg McNutt. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var kinesisRecorder: AWSKinesisRecorder!
    var timeLastFlush = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // see if we are already logged in
        let delegate = AuthorizeUserDelegate(parentController: self)
        delegate.launchGetAccessToken()
        
        // set up location service
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = 5
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        // tune kinesis
        kinesisRecorder = AWSKinesisRecorder.defaultKinesisRecorder()
        kinesisRecorder.diskAgeLimit = 30 * 24 * 60 * 60; // 30 days
        kinesisRecorder.diskByteLimit = 5 * 1024 * 1024; // 10MB
        kinesisRecorder.notificationByteThreshold = 4 * 1024 * 1024; // 5MB
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        // update ui
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a" // superset of OP's format
        let locationStr = dateFormatter.stringFromDate(NSDate()) + ": \(locValue.latitude) \(locValue.longitude)"
        locationText.text = locationStr
        
        // and queue it to kinesis
        let position = locationStr.dataUsingEncoding(NSUTF8StringEncoding)
        
        // TODO some work to do here with async errors, yada
        let task = kinesisRecorder.saveRecord(position, streamName: "watch")
        
        if (kinesisRecorder.diskBytesUsed > 1000000 ||
            NSDate().timeIntervalSinceDate(timeLastFlush) > 30) {
            task.waitUntilFinished()
            kinesisRecorder.submitAllRecords()
            timeLastFlush = NSDate()
            lastFlushTime.text = dateFormatter.stringFromDate(timeLastFlush)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var lastFlushTime: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet var photoFrame: [UIImageView]!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var idField: UILabel!
    @IBOutlet weak var postalField: UILabel!
    
//    @IBAction func fetchS3(sender: AnyObject) {
//        let key = "DSCF3169.png"
//        let bucket = "watchtest.accelero.com"
//        
//        let downloadFilePath = NSTemporaryDirectory().stringByAppendingPathComponent(key)
//        let downloadingFileURL = NSURL.fileURLWithPath(downloadFilePath)
//                
//        let downloadRequest = AWSS3TransferManagerDownloadRequest()
//        downloadRequest.bucket = bucket
//        downloadRequest.key  = key
//        downloadRequest.downloadingFileURL = downloadingFileURL
//        
//        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
//        transferManager.download(downloadRequest).continueWithBlock {
//            (task: BFTask!) -> AnyObject! in
//            if task.error != nil {
//                let error = UIAlertView(title: "",
//                    message: "errorMessage:" + task.error.description,
//                    delegate: nil,
//                    cancelButtonTitle: "OK")
//                error.show()
//            }
//            else {
//                // Set the UIImageView to show the file that was downloaded
//                let image = UIImage(contentsOfFile: downloadFilePath)
//                
//                self.photoFrame[0].image = image
//            }
//            
//            return nil
//        } // end closure
//    }
    
    @IBAction func amznLogin(sender: AnyObject) {
        // Requesting both scopes for the current user.
        var requestScopes: [String] = ["profile", "postal_code"]
        let delegate = AuthorizeUserDelegate(parentController: self)
        AIMobileLib.authorizeUserForScopes(requestScopes, delegate: delegate)
    }
    
    @IBAction func amznLogout(sender: AnyObject) {
        let delegate = LogoutDelegate(parentController: self)
        
        AIMobileLib.clearAuthorizationState(delegate)
    }

    @IBAction func locationState(sender: UISwitch) {
        if (sender.on) {
            locationManager.startUpdatingLocation()
            locationText.textColor = UIColor.redColor()
        } else {
            locationManager.stopUpdatingLocation()
            locationText.textColor = UIColor.blueColor()
        }
    }
}

