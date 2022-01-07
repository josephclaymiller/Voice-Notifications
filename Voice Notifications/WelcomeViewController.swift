//
//  WelcomeViewController.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 12/31/21.
//

import UIKit
import AVFAudio

enum permission: String {
    case microphone
    case notification
}

class WelcomeViewController: UIViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    var recordingSession: AVAudioSession!
    var soundManager: SoundManager! = SoundManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recordingSession = soundManager.recordingSession
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        // Ask permission only one time
        askPermission()
        self.dismiss(animated: true, completion: nil)
    }
    
    // permission for audio recording and for sending notifications
    func askPermission() {
        print("Ask permission")
        askMicrophonePermission()
        askNotificationPermission()
    }
    
    func askMicrophonePermission() {
        recordingSession.requestRecordPermission() { [unowned self] allowed in
            DispatchQueue.main.async {
                if allowed {
                    // can record
                    print("Have permission to record audio")
                } else {
                    // can only ask permission once, must be changed in settings after
                    directUserToSettings(.microphone)
                }
            }
        }
    }
    
    func askNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Have permission to send audio notifications")
            } else {
                print("Don't have permission to send notifications")
                DispatchQueue.main.async {
                    self.directUserToSettings(.notification)
                }
            }
        }
    }
    
    // alert user to go to settings
    func directUserToSettings(_ missingPermission: permission) {
        // initialise a pop up for using later
        var alertTitle = "Access to"
        var permissionMessage = "Please go to Settings and turn on the "
        switch missingPermission {
        case .microphone:
            alertTitle = "Access to Microphone"
            permissionMessage += "permission to access the Microphone."
        case .notification:
            alertTitle = "Notification Permission"
            permissionMessage += "permission for Notifications."
        }
        let alertController = UIAlertController(title: alertTitle, message: permissionMessage, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
             }
        }
        let cancelAction = UIAlertAction(title: "Quit", style: .default, handler: { _ in
            // Quit application if access to microphone not granted since there is nothing to do without it
            exit(0)
        })

        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
