//
//  InputFormGroup.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit


class InputFormGroup : UIView {
    
    private var inputFormGroupDelegate: InputFormGroupDelegate
    private var profileFieldType: ProfileFieldType
    private let inputLabel: UILabel
    let inputField: UITextFieldDefault
    
    required init(
        parentController: UIViewController,
        inputFormGroupDelegate: InputFormGroupDelegate,
        profileFieldType: ProfileFieldType,
        titleLable: String,
        keyboardType: UIKeyboardType,
        secureTextEntry: Bool = false
    ){
        self.inputFormGroupDelegate = inputFormGroupDelegate
        self.profileFieldType = profileFieldType
        inputLabel = UILabel()
        inputField = UITextFieldDefault("", keyboardType, secureTextEntry)
        super.init(frame: CGRect())
        
        
        //let inputLabel = UILabel()
        inputLabel.text = titleLable
        //inputLabel.backgroundColor = .green
        inputLabel.textColor = .white
        inputLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        inputLabel.textAlignment = .left
        
        self.addSubview(inputLabel)
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        inputLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        inputLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        //let usernameField = UITextFieldDefault("", keyboardType)
        self.addSubview(inputField)
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        inputField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        inputField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        inputField.addTarget(self, action: #selector(updateFieldValue), for: .editingChanged)
        inputField.delegate = parentController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func updateFieldValue(_ textField: UITextFieldDefault){
        //print("updateFieldValue")
        self.inputFormGroupDelegate.updateFieldValue(profileFieldType: self.profileFieldType, value: textField.text)
    }
    
    public func setInputValue(value: String){
        self.inputField.text = value
    }
    
    public func getInputValue() -> String? {
        return self.inputField.text
    }
    
    
}
