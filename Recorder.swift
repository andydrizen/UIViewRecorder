//
//  Recorder.swift
//  aninative
//
//  Created by Andy Drizen on 03/01/2015.
//  Copyright (c) 2015 Andy Drizen. All rights reserved.
//

import UIKit

public class Recorder: NSObject {
    var displayLink : CADisplayLink?
    
    var imageCounter = 0
    public var view : UIView?
    var outputPath : NSString?
    var referenceDate : NSDate?
    var outputJPG = false
    
    public func start() {
        
        if (view == nil) {
            NSException(name: "No view set", reason: "You must set a view before calling start.", userInfo: nil).raise()
        }
        else {
            displayLink = CADisplayLink(target: self, selector: "handleDisplayLink:")
            displayLink!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            
            referenceDate = NSDate()
        }
    }
    
    public func stop() {
        displayLink?.invalidate()
        
        let seconds = referenceDate?.timeIntervalSinceNow
        if (seconds != nil) {
            println("Recorded: \(imageCounter) frames\nDuration: \(-1 * seconds!) seconds\nStored in: \(outputPathString())")
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
    
    func outputPathString() -> String {
        if (outputPath != nil) {
            return outputPath!
        }
        else {
            return applicationDocumentsDirectory.absoluteString!
        }
    }
    
    func createImageFromView(captureView : UIView) {
        UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, false, 0)
        captureView.drawViewHierarchyInRect(captureView.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        var fileExtension = "png"
        var data : NSData?
        if (outputJPG) {
            data = UIImageJPEGRepresentation(image, 1)
            fileExtension = "jpg"
        }
        else {
            data = UIImagePNGRepresentation(image)
        }
        
        imageCounter = imageCounter + 1
        var path = outputPathString()
        path = path.stringByAppendingPathComponent("/image\(imageCounter).\(fileExtension)")
        
        data!.writeToURL(NSURL(string: path)!, atomically: false)
        
        UIGraphicsEndImageContext();
    }
}
