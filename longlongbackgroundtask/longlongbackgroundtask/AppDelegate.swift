//
//  AppDelegate.swift
//  longlongbackgroundtask
//
//  Created by  lifirewolf on 15/8/24.
//  Copyright (c) 2015年  lifirewolf. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var audioPlayer: AVAudioPlayer!
    var audioEngine = AVAudioEngine()
    
    let app = UIApplication.sharedApplication()
    
    var window: UIWindow?
    
    var bgTask: UIBackgroundTaskIdentifier!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        println("application Will Enter Background")
        
        self.bgTask = app.beginBackgroundTaskWithExpirationHandler() {
            self.app.endBackgroundTask(self.bgTask)
            self.bgTask = UIBackgroundTaskInvalid
        }
        
        NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "applyForMoreTime", userInfo: nil, repeats: true)
        
        // now, do what you want to do
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "doSomething", userInfo: nil, repeats: true)
    }
    
    func doSomething() {
        println("doing something, \(app.backgroundTimeRemaining)")
    }
    
    func applyForMoreTime() {
        
        if app.backgroundTimeRemaining < 30 {
            
            let filePathUrl = NSURL(string: NSBundle.mainBundle().pathForResource("1", ofType: "wav")!)!
            
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: AVAudioSessionCategoryOptions.MixWithOthers, error: nil)
            
            self.audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            
            self.audioEngine.reset()
            self.audioPlayer.play()
            
            self.app.endBackgroundTask(self.bgTask)
            self.bgTask = app.beginBackgroundTaskWithExpirationHandler() {
                self.app.endBackgroundTask(self.bgTask)
                self.bgTask = UIBackgroundTaskInvalid
            }
        }
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        println("application Will Enter Foreground")
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

