//
//  HelpViewController.swift
//  mvp
//
//  Created by adham soliman on 20.02.23.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var helpTextField: UITextView!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.layer.cornerRadius = 10
        helpTextField.isEditable = false
        helpTextField.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
