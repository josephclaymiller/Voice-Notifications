//
//  CreateVoiceNotificationViewController.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 12/31/21.
//

import UIKit

class CreateVoiceNotificationViewController: UIViewController, UIPickerViewDelegate {
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var bodyTextField: UITextView!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var saveBarButton: UIBarButtonItem!
  @IBOutlet weak var recordButton: UIButton!
  
  var isRecording: Bool = false
  var recordedMessageFilename: String?
  var saveEnabled: Bool = false
  
  // sound manager to manage audio recordings
  let soundManager = SoundManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    print("Create Voice Notification view loaded")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print("Create Voice Notification view appeared")
    saveBarButton.isEnabled = saveEnabled
    if saveEnabled {
      recordButton.setTitle("Re-record Message", for: .normal)
    }
  }

  // transition to record message view
  @IBAction func recordButtonPressed(_ sender: UIButton) {
    print("Record message Segue")
    performSegue(withIdentifier: "recordSegue", sender: self)
  }
  
  @IBAction func setNotificationButtonPressed(_ sender: Any) {
    print(#function)
    let seconds = datePicker.countDownDuration
    let title = titleTextField.text!
    let body = bodyTextField.text!
    let notification = Notification(title: title, body: body, seconds: seconds)
    print("\(notification.title) in \(notification.seconds) seconds")
  
    navigationController?.popViewController(animated: true)
  }
  
  // TODO: Let user set date for notification instead of timer
    @IBAction func datePicked(_ sender: UIDatePicker) {
      print(#function)
      print(sender.countDownDuration) // time selected in seconds
    }
  
  func testFunc() {
    print(#function)
  }

  
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
     if segue.identifier == "recordSegue" {
       print("Prepare for segue to record voice view controller")
       let recordView = segue.destination as! RecordMessageViewController
       recordView.delegate = self
     }
   }
   
  
}
