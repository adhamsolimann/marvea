//
//  PopupViewController.swift
//  mvp
//
//  Created by adham soliman on 17.02.23.
//

import UIKit

class PopupViewController: UIViewController {
        

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var performanceLabel: UILabel!
    
    @IBOutlet weak var launchLabel: UILabel!
    
    @IBOutlet weak var savedCO2Label: UILabel!
    
    @IBOutlet weak var energyRatingImageView1: UIImageView!
    @IBOutlet weak var energyRatingImageView2: UIImageView!
    @IBOutlet weak var energyRatingImageView3: UIImageView!
    
    @IBOutlet weak var energyTypeLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText: String?
    var addressText: String?
    var performanceText: String?
    var launchText: String?
    var image: String?
    var tagText: String?
    var saved_CO2: Float = 0
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
        headerImageView.image = UIImage(named: tagText!)
        
        // Logic for displaying the energy rating depending on the performance
        
        if  Float(performanceText!)! < 250 {
            energyRatingImageView1.alpha = 1.0
            energyRatingImageView2.alpha = 0.3
            energyRatingImageView3.alpha = 0.3
        }
        else if Float(performanceText!)! > 250 && Float(performanceText!)! < 500 {
            energyRatingImageView1.alpha = 1.0
            energyRatingImageView2.alpha = 1.0
            energyRatingImageView3.alpha = 0.3
        }
        else {
            energyRatingImageView1.alpha = 1.0
            energyRatingImageView2.alpha = 1.0
            energyRatingImageView3.alpha = 1.0
        }
        
        dismissButton.layer.cornerRadius = 10
        
        
        // Check the object's tag. Then, change displayed text; if aggregated, use plural language.
        
        if let energyText = tagText {
            let flag = String(energyText.suffix(4)) // last3Chars = "_agg"
            
            if flag == "_agg" {
                if let titleText = titleText {
                    nameLabel.text = "Gesamte Anzahl: \(titleText)"
                }
                if let addressText = addressText {
                    addressLabel.text = "Adresse: \(addressText)"
                }
                if let performanceText = performanceText {
                    performanceLabel.text = "Gesamte Leistung: \(performanceText) kW"
                }
                if let launchText = launchText {
                    launchLabel.text = "Inbetriebnahme: \(launchText)"
                }
                
                // Display passed data in pop over & calculate saved CO2-emissions
                
                saved_CO2 = (Float(performanceText!)! * 0.349)
            savedCO2Label.text = "Eingesparte CO2 Emissionen:\n \(round(saved_CO2 * 10) / 10.0) kg/CO2"
            
                if let tagText = tagText {
                    let aggEnergyType = String(tagText.dropLast(4))
                    energyTypeLabel.text = "Energietyp: \(aggEnergyType)"
                }
            }
            else {
                
                    if let titleText = titleText {
                        nameLabel.text = "Name: \(titleText)"
                    }
                    if let addressText = addressText {
                        addressLabel.text = "Adresse: \(addressText)"
                    }
                    if let performanceText = performanceText {
                        performanceLabel.text = "Leistung: \(performanceText) kW"
                    }
                    if let launchText = launchText {
                        launchLabel.text = "Inbetriebnahme: \(launchText)"
                    }
                
                // Display passed data in pop over & calculate saved CO2-emissions

                    saved_CO2 = (Float(performanceText!)! * 0.349)
                savedCO2Label.text = "Eingesparte CO2 Emissionen:\n \(round(saved_CO2 * 10) / 10.0) kg/CO2"
                
                    if let tagText = tagText {
                        energyTypeLabel.text = "Energietyp: \(tagText)"
                    }
                }
            }
        }
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
