//
//  AppDelegate.swift
//  InvisibleCities
//
//  Created by Leo on 07.07.14.
//  Copyright (c) 2014 Leo. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    let webServer = GCDWebServer()
    
    let audioSession = AVAudioSession.sharedInstance()
    
    var audioError: NSError?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
    
        let docRoot = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/Cities")
        webServer.addGETHandlerForBasePath("/", directoryPath: docRoot, indexFilename: "index.html", cacheAge: 3600, allowRangeRequests: true)
        webServer.startWithPort(8116, bonjourName: nil)

        do {
            try audioSession.setCategory(AVAudioSessionCategorySoloAmbient)
        } catch let error as NSError {
            audioError = error
        }
        
        if ((audioError) != nil) {
            print(audioError)
        }
        
        do {
            try audioSession.setActive(true)
        } catch let error as NSError {
            audioError = error
        }
        
        if ((audioError) != nil) {
            print(audioError)
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        do {
             try audioSession.setActive(false)
        } catch let error as NSError {
            audioError = error
        }
        
        if ((audioError) != nil) {
            print(audioError)
        }

    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        do {
            //try audioSession.setActive(false)
            try audioSession.setInputGain(1)
        } catch let error as NSError {
            audioError = error
        }
        
        if ((audioError) != nil) {
            print(audioError)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        print("mem warn")
        NSURLCache.sharedURLCache().removeAllCachedResponses()
    }
    
}

