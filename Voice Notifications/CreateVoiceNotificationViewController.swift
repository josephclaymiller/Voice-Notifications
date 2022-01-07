//
//  CreateVoiceNotificationViewController.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 12/31/21.
//

import UIKit

class CreateVoiceNotificationViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextField: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    var isRecording: Bool = false
    
    // sound manager to manage audio recordings
    let soundManager = SoundManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        print(#function)
        soundManager.toggleRecording()
        switch isRecording {
        case false:
            sender.setTitle("Stop Recording", for: .normal)
        case true:
            sender.setTitle("Re-record", for: .normal)
        }
        isRecording = !isRecording
    }
    
    @IBAction func setNotificationButtonPressed(_ sender: UIButton) {
        print(#function)
        let seconds = datePicker.countDownDuration
        let title = titleTextField.text!
        let body = bodyTextField.text!
        let notification = Notification(title: title, body: body, seconds: seconds)
        print(notification.seconds)
    }
    

   // TODO: Let user set date for notification instead of timer
//        @IBAction func datePicked(_ sender: UIDatePicker) {
//        print(#function)
//        print(sender.countDownDuration) // time selected in seconds
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
