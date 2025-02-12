//
//  Checkbox.swift
//  mvp
//
//  Created by adham soliman on 17.02.23.
//

import UIKit
import Foundation

class CheckboxButton: UIButton {
    // Images for unchecked and checked states
    let uncheckedImage = UIImage(named: "checkbox")
    let checkedImage = UIImage(named: "checkbox_checked")
    
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
        self.isSelected = true
        self.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
