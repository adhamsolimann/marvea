//
//  RadioButton.swift
//  mvp
//
//  Created by adham soliman on 17.02.23.
//

import UIKit

class RadioButton: UIButton {
    // Images for unchecked and checked states
    let uncheckedImage = UIImage(named: "radiobutton")
    let checkedImage = UIImage(named: "radiobutton_checked")
    
    // Keep track of all radio buttons in the same group
    static var radioButtonGroups = [Int: [RadioButton]]()
    var groupId: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.setImage(uncheckedImage, for: .normal)
        self.setImage(checkedImage, for: .selected)
        //self.isSelected = false
        
        // Add this button to the radio button group
        if RadioButton.radioButtonGroups[groupId] == nil {
            RadioButton.radioButtonGroups[groupId] = [self]
        } else {
            RadioButton.radioButtonGroups[groupId]?.append(self)
        }
        
        self.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: RadioButton) {
        if sender.isSelected {
            // Do not unselect this button, leave it selected
            return
        }
    
        // Unselect all other buttons in the same group
        if let buttons = RadioButton.radioButtonGroups[groupId] {
            for button in buttons {
                if button != sender {
                    button.isSelected = false
                }
            }
        }
        
        sender.isSelected = true
    }
}
