//
//  RecordVoiceViewController.swift
//  Voice Notifications
//
//  Created by Joe Miller on 2/8/24.
//

import UIKit

class RecordMessageViewController: UIViewController {
  
  var isRecording: Bool = false
  
  weak var delegate: CreateVoiceNotificationViewController?
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  // sound manager to manage audio recordings
  let soundManager = SoundManager.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    saveButton.isEnabled = false
    playButton.isEnabled = false
  }
  
  //FIXME: cancel recording if "save" button is not pressed
  // tapping cancel after play causes bugs
  @IBAction func recordButtonPressed(_ sender: UIButton) {
    print(#function)
    soundManager.toggleRecording()
    switch isRecording {
    case false:
      sender.setTitle("Stop", for: .normal)
    case true:
      playButton.isEnabled = true
      saveButton.isEnabled = true
      sender.setTitle("Re-record", for: .normal)
    }
    isRecording = !isRecording
  }
  
  @IBAction func playButtonPressed(_ sender: UIButton) {
    soundManager.playRecording()
    print("Playing recording")
  }
  
  @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
    print("Enable Save and close view")
    delegate?.saveEnabled = true
    navigationController?.popViewController(animated: true)
  }
  
}
