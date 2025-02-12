//
//  FilterViewController.swift
//  mvp
//
//  Created by adham soliman on 17.02.23.
//

import UIKit



class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var biomasseButton: CheckboxButton!
    @IBOutlet weak var windButton: CheckboxButton!
    @IBOutlet weak var solarButton: CheckboxButton!
    
    @IBOutlet weak var radiusLabel: UILabel!

    @IBOutlet weak var twoKmButton: RadioButton!
    @IBOutlet weak var fiveKmButton: RadioButton!
    @IBOutlet weak var tenKmButton: RadioButton!
    
    @IBOutlet weak var applyButton: UIButton!
    
    var isTwoKmSelected = true {
        didSet {
            if isTwoKmSelected {
                isFiveKmSelected = false
                isTenKmSelected = false
            }
            UserDefaults.standard.set(isTwoKmSelected, forKey: "isTwoKmSelected")
        }
    }

    var isFiveKmSelected = false {
        didSet {
            if isFiveKmSelected {
                isTwoKmSelected = false
                isTenKmSelected = false
            }
            UserDefaults.standard.set(isFiveKmSelected, forKey: "isFiveKmSelected")
        }
    }

    var isTenKmSelected = false {
        didSet {
            if isTenKmSelected {
                isTwoKmSelected = false
                isFiveKmSelected = false
            }
            UserDefaults.standard.set(isTenKmSelected, forKey: "isTenKmSelected")
        }
    }
    
    var isBiomasseSelected = true {
        didSet {
            UserDefaults.standard.set(isBiomasseSelected, forKey: "isBiomasseSelected")
        }
    }
    var isWindSelected = true {
        didSet {
            UserDefaults.standard.set(isWindSelected, forKey: "isWindSelected")
        }
    }
    var isSolarSelected = true {
        didSet {
            UserDefaults.standard.set(isSolarSelected, forKey: "isSolarSelected")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyButton.layer.cornerRadius = 10
        
        // Load the checkbox states from UserDefaults
        isBiomasseSelected = UserDefaults.standard.bool(forKey: "isBiomasseSelected")
        isWindSelected = UserDefaults.standard.bool(forKey: "isWindSelected")
        isSolarSelected = UserDefaults.standard.bool(forKey: "isSolarSelected")
        
        isTwoKmSelected = UserDefaults.standard.bool(forKey: "isTwoKmSelected")
        isFiveKmSelected = UserDefaults.standard.bool(forKey: "isFiveKmSelected")
        isTenKmSelected = UserDefaults.standard.bool(forKey: "isTenKmSelected")
        
        // Set the checkbox states based on the loaded values
        biomasseButton.isSelected = isBiomasseSelected
        windButton.isSelected = isWindSelected
        solarButton.isSelected = isSolarSelected
        
        twoKmButton.isSelected = isTwoKmSelected
        fiveKmButton.isSelected = isFiveKmSelected
        tenKmButton.isSelected = isTenKmSelected

        // Do any additional setup after loading the view.
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        biomasseButton.isSelected = isBiomasseSelected
    //        windButton.isSelected = isWindSelected
    //        solarButton.isSelected = isSolarSelected
    //        }
    
    @IBAction func biomasseButtonPressed(_ sender: Any) {
        isBiomasseSelected = !isBiomasseSelected
    }
    
    @IBAction func windButtonPressed(_ sender: Any) {
        isWindSelected = !isWindSelected
    }
    
    @IBAction func solarButtonPressed(_ sender: Any) {
        isSolarSelected = !isSolarSelected
    }
    
    @IBAction func twoKmPressed(_ sender: Any) {
        isTwoKmSelected = true
    }
    
    @IBAction func fiveKmPressed(_ sender: Any) {
        isFiveKmSelected = true
    }

    @IBAction func tenKmPressed(_ sender: Any) {
        isTenKmSelected = true
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(isBiomasseSelected, forKey: "isBiomasseSelected")
        UserDefaults.standard.set(isWindSelected, forKey: "isWindSelected")
        UserDefaults.standard.set(isSolarSelected, forKey: "isSolarSelected")
        
        // Apply filters
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterApplied"), object: nil)
        
        dismiss(animated: true, completion: nil)
      }
                
    @IBAction func backButtonPressed(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
    }
