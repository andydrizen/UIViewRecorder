//
//  Recorder.swift
//  aninative
//
//  Created by Andy Drizen on 03/01/2015.
//  Copyright (c) 2015 Andy Drizen. All rights reserved.
//

import UIKit

class Recorder: NSObject {
    var displayLink : CADisplayLink?
    
    var imageCounter = 0
    var view : UIView?
    var outputPath : NSString?
    var referenceDate : NSDate?
    var outputJPG = false
    
    func start() {
        
        if (view == nil) {
            NSException(name: "No view set", reason: "You must set a view before calling start.", userInfo: nil).raise()
        }
        else {
            displayLink = CADisplayLink(target: self, selector: "handleDisplayLink:")
            displayLink!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            
            referenceDate = NSDate()
        }
    }
    
    func stop() {
        displayLink?.invalidate()
        
        let seconds = referenceDate?.timeIntervalSinceNow
        if (seconds != nil) {
            println("Recorded \(imageCounter) images for a duration of \(-1 * seconds!) seconds, stored in: \(applicationDocumentsDirectory)")
        }
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.andydrizen.test" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count - 1] as NSURL
        }()
    
    func handleDisplayLink(displayLink : CADisplayLink) {
        if (view != nil) {
            createImageFromView(view!)
        }
    }
    
    func createImageFromView(captureView : UIView) {
        UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, false, 0)
        captureView.drawViewHierarchyInRect(captureView.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        let data = (outputJPG) ? UIImageJPEGRepresentation(image, 0) : UIImagePNGRepresentation(image)
        
        imageCounter = imageCounter + 1
        var path : NSString?
        
        if (outputPath != nil) {
            path = outputPath
        }
        else {
            path = applicationDocumentsDirectory.absoluteString!.stringByAppendingPathComponent("/image\(imageCounter).png")
        }
        
        data.writeToURL(NSURL(string: path!)!, atomically: false)
        
        UIGraphicsEndImageContext();
    }
}
