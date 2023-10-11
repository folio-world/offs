//
//  AppDelegate.swift
//  OffFeatureCalendarDemo
//
//  Created by 송영모 on 10/11/23.
//

import UIKit
import SwiftUI
import AppTrackingTransparency

import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
        
        } else {
            ATTrackingManager.requestTrackingAuthorization { status in
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            }
        }

      return true
    }
}
