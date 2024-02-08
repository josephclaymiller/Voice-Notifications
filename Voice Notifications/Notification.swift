//
//  Notification.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 1/1/22.
//

import Foundation
import UIKit

class Notification {
  static var all: [Notification] = []
  static let notificationCenter = UNUserNotificationCenter.current()
  
  var title: String
  var body: String
  //    var soundFileName: String
  var seconds: TimeInterval
  
  init(title: String, body: String, seconds: TimeInterval) {
    self.title = title
    self.body = body
    self.seconds = seconds
    createNotification()
    Notification.all.append(self)
  }
  
  private func createNotification() {
    print(#function)
    let content = UNMutableNotificationContent()
    let notificatinSoundFileName = UNNotificationSoundName(rawValue: SoundManager.shared.audioFileName)
    content.title = title
    content.body = body
    content.sound = UNNotificationSound(named: notificatinSoundFileName)
    
    // Configure the recurring date.
    //        var dateComponents = DateComponents()
    //        dateComponents.calendar = Calendar.current
    //        dateComponents.weekday = day  // Tuesday
    //        dateComponents.hour = hour    // 14:00 hours
    
    // Create the trigger as a repeating event.
    //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
    
    // Create the request
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString,
                                        content: content, trigger: trigger)
    
    // Schedule the request with the system.
    Notification.notificationCenter.add(request) { (error) in
      if error != nil {
        // Handle any errors.
        print("Could not create notification")
      }
      print(Notification.notificationCenter.getPendingNotificationRequests(completionHandler: { request in
        print(request)
      }))
    }
  }
  
}

