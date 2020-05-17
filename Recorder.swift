//
//  Recorder.swift
//  aninative
//
//  Created by Andy Drizen on 03/01/2015.
//  Copyright (c) 2015 Andy Drizen. All rights reserved.
//

import UIKit

@objc public class Recorder: NSObject {
    var displayLink : CADisplayLink?
    
    var imageCounter = 0
    public var view : UIView?
    var outputPath : NSString?
    var referenceDate : NSDate?
    public var name = "image"
    public var outputJPG = false
    
    public func start() {
        
        if (view == nil) {
            NSException(name: NSExceptionName(rawValue: "No view set"), reason: "You must set a view before calling start.", userInfo: nil).raise()
        }
        else {
            displayLink = CADisplayLink(target: self, selector: #selector(self.handleDisplayLink(displayLink:)))
            displayLink!.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
            
            referenceDate = NSDate()
        }
    }
    
    public func stop() {
        displayLink?.invalidate()
        
        let seconds = referenceDate?.timeIntervalSinceNow
        if (seconds != nil) {
            print("Recorded: \(imageCounter) frames\nDuration: \(-1 * seconds!) seconds\nStored in: \(outputPathString())")
        }
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.andydrizen.test" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1] as NSURL
        }()
    
    @objc func handleDisplayLink(displayLink : CADisplayLink) {
        if (view != nil) {
            createImageFromView(captureView: view!)
        }
    }
    
    func outputPathString() -> NSString {
        if (outputPath != nil) {
            return outputPath! as NSString
        }
        else {
            return applicationDocumentsDirectory.absoluteString! as NSString
        }
    }
    
    func createImageFromView(captureView : UIView) {
        UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, false, 0)
        captureView.drawHierarchy(in: captureView.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        
        var fileExtension = "png"
        var data : NSData?
        if (outputJPG) {
            data = image!.jpegData(compressionQuality: 1) as NSData?
            fileExtension = "jpg"
        }
        else {
            data = image!.pngData() as NSData?
        }
        
        var path = outputPathString()
        path = path.appendingPathComponent("/\(name)-\(imageCounter).\(fileExtension)") as NSString
        
        imageCounter = imageCounter + 1
        
        if let imageRaw = data {
            imageRaw.write(to: NSURL(string: path as String)! as URL, atomically: false)
        }
        
        UIGraphicsEndImageContext();
    }
}
