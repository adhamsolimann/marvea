//
//  FacilityDetailsViewController.swift
//  mvp
//
//  Created by adham soliman on 23.01.23.
//

import UIKit
class MenuViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!

    @IBOutlet weak var filterButton: UIButton!
    
    
    @IBOutlet weak var aggregateLabel: UILabel!
    @IBOutlet weak var aggregationCheckbox: CheckboxButton!
    @IBOutlet weak var viewHelpButton: UIButton!
    
    
    var isAggregationSelected = false {
        didSet {
            UserDefaults.standard.set(isAggregationSelected, forKey: "isAggregationSelected")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        
        isAggregationSelected = UserDefaults.standard.bool(forKey: "isAggregationSelected")
        aggregationCheckbox.isSelected = isAggregationSelected

        dismissButton.layer.cornerRadius = 10
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        print("Filter pressed")
        let filterVC = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") 
        present(filterVC!, animated: true, completion: nil)
    }
    
    @IBAction func aggregateButtonPressed(_ sender: Any) {

    }
    
    @IBAction func helpButtonPressed(_ sender: Any) {
    print("View help pressed")
       let helpVC = storyboard?.instantiateViewController(withIdentifier: "HelpViewController")
        present(helpVC!, animated: true, completion: nil)
    }
    
    @IBAction func aggregationCheckboxPressed(_ sender: Any) {
        print("Aggregate pressed")
        isAggregationSelected = !isAggregationSelected
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(isAggregationSelected, forKey: "isAggregtionSelected")
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AggregationEnabled"), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AggregationApplied"), object: nil)
        
        dismiss(animated: true, completion: nil)
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
