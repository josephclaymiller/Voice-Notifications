//
//  ViewController.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 12/31/21.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {
    // persistence
    let defaults = UserDefaults.standard
    // audio session to manage recording
    // audio recorder to handle reading and saving of data
    var recordingSession: AVAudioSession!
//    var audioRecorder: AVAudioRecorder!
//    var audioPlayer: AVAudioPlayer!
//    let audioFileName = "voice_memo_recording.m4a"
//    var audioFileURL: URL {
//        getSoundFolder().appendingPathComponent(audioFileName)
//    }
    // notifications
    let notificationCenter = UNUserNotificationCenter.current()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set as new user if not yet set
        if defaults.value(forKey: "isNewUser") == nil {
            defaults.set(true, forKey: "isNewUser")
        }
        // Audio Recorder
        recordingSession = AVAudioSession.sharedInstance()

        // cancel all notifications previously scheduled for testing
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check if new user and if so show welcome message
//        defaults.set(true, forKey: "isNewUser") // testing
        if defaults.value(forKey: "isNewUser") as! Bool {
            showWelcomeMessage()
            defaults.set(false, forKey: "isNewUser")
        } else {
            showCreateView()
        }
    }
    
    func showCreateView() {
        performSegue(withIdentifier: "createSegue", sender: self)
    }
    
    func showWelcomeMessage() {
        // TODO: add welcome view
        print("Welcome Segue")
        performSegue(withIdentifier: "welcomeSegue", sender: self)
    }
    
    func getSoundFolder() -> URL {
        let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent("Sounds", isDirectory: true)
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
        return url
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "welcomeSegue" {
            let destination = segue.destination as! WelcomeViewController
            destination.recordingSession = recordingSession
        }
    }
}

