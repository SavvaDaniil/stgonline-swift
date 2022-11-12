//
//  UITextFieldDefault.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

class UITextFieldDefault : UITextField {
    
    init(_ placeholder: String, _ keyboardType: UIKeyboardType, _ secureTextEntry: Bool = false){
        super.init(frame: CGRect())
        
        self.textColor = .white
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.3)]
        )
        self.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 20)
        self.borderStyle = .none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = keyboardType
        self.isSecureTextEntry = secureTextEntry
        
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.contentVerticalAlignment = .center
        
        let fieldBorder = UIView(frame: CGRect())
        fieldBorder.backgroundColor = GlobalVariables.activeColor
        self.addSubview(fieldBorder)
        fieldBorder.translatesAutoresizingMaskIntoConstraints = false
        fieldBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4).isActive = true
        fieldBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        fieldBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        fieldBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
