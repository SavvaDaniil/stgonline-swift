//
//  InputFormGroupFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

enum ProfileFieldType {
    case username
    case passwordNew
    case passwordNewAgain
    case passwordCurrent
}


class InputFormGroupFactory {
    
    public func create(
        parentController: UIViewController,
        parentView: UIView,
        topView: UIView?,
        constantStepFromTopView: Int = 20,
        inputFormGroupDelegate: InputFormGroupDelegate,
        profileFieldType: ProfileFieldType,
        titleLable: String,
        keyboardType: UIKeyboardType,
        secureTextEntry: Bool = false
    ) -> InputFormGroup {
        
        let inputFormGroup = InputFormGroup(
            parentController: parentController,
            inputFormGroupDelegate: inputFormGroupDelegate,
            profileFieldType: profileFieldType,
            titleLable: titleLable,
            keyboardType: keyboardType,
            secureTextEntry: secureTextEntry
        )
        parentView.addSubview(inputFormGroup)
        inputFormGroup.translatesAutoresizingMaskIntoConstraints = false
        if topView == nil {
            inputFormGroup.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 20).isActive = true
        } else {
            inputFormGroup.topAnchor.constraint(equalTo: topView!.bottomAnchor, constant: 20).isActive = true
        }
        inputFormGroup.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        inputFormGroup.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        inputFormGroup.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return inputFormGroup
    }
}

