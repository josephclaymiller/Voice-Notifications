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
    
    // notifications
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set as new user if not yet set
        if defaults.value(forKey: "isNewUser") == nil {
            defaults.set(true, forKey: "isNewUser")
        }

        // cancel all notifications previously scheduled for testing
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        // Check if new user and if so show welcome message
//        defaults.set(true, forKey: "isNewUser") // testing
        if let isNewUser = defaults.value(forKey: "isNewUser") as? Bool {
            if isNewUser {
                showWelcomeMessage()
                defaults.set(false, forKey: "isNewUser")
            }
        }
    }
    
    func showWelcomeMessage() {
        print("Welcome Segue")
        performSegue(withIdentifier: "welcomeSegue", sender: self)
    }
    
    func showCreateView() {
        performSegue(withIdentifier: "createSegue", sender: self)
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        showCreateView()
    }
    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "welcomeSegue" {
            let destination = segue.destination as! WelcomeViewController
        }
    }
    */
}

