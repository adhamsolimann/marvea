//
//  ViewController.swift
//  mvp
//
//  Created by adham soliman on 05.01.23.
//

import UIKit
import AVFoundation
import CoreLocation

class TermsAndConditionsViewController: UIViewController {

    
    @IBOutlet weak var termsLabel: UILabel!
        
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var declineButton: UIButton!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acceptButton.layer.cornerRadius = 10
        declineButton.layer.cornerRadius = 10
        termsTextView.isEditable = false
        termsTextView.layer.cornerRadius = 5
    }

    
    
    
    
    @IBAction func agreeButtonPressed(_ sender: Any) {
        
        let startingVisualisationVC = storyboard?.instantiateViewController(withIdentifier: "StartingVisualisationViewController")
        present(startingVisualisationVC!, animated: true, completion: nil)
    }
    
    @IBAction func declineButtonPressed(_ sender: Any) {
        let errorVC = storyboard?.instantiateViewController(withIdentifier: "ErrorViewController")
        present(errorVC!, animated: true, completion: nil)
    }
}


