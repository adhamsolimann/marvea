//
//  ErrorViewController.swift
//  mvp
//
//  Created by adham soliman on 05.01.23.
//

import UIKit

class ErrorViewController: UIViewController {
    
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errormessageTextView: UITextView!
    @IBOutlet weak var goToSettingsButton: UIButton!
    
    func openSettings()
       {
           let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
           UIApplication.shared.open(settingsUrl)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        goToSettingsButton.backgroundColor = UIColor.systemGray5
        goToSettingsButton.layer.cornerRadius = 10
        errormessageTextView.isEditable = false
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToSettingsButtonPressed(_ sender: Any) {
        openSettings()
    }
}
