//
//  CreateVoiceNotificationViewController.swift
//  Voice Notifications
//
//  Created by Joseph Miller on 12/31/21.
//

import UIKit

class CreateVoiceNotificationViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        print(#function)
    }
    
    @IBAction func setNotificationButtonPressed(_ sender: UIButton) {
        print(#function)
    }
    
    @IBAction func datePicked(_ sender: UIDatePicker) {
        print(#function)
        print(sender.date)
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
