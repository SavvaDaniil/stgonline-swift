//
//  BtnTabFooterFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

enum BtnTabFooterPosition : Int {
    case LESSONS = 0
    case PURCHASES = 1
    case PROFILE = 2
}

class BtnTabFooterFactory {
    
    public func create(parentController: UIViewController, parentView: UIView, iconName: String, btnTabFooterPosition: BtnTabFooterPosition, isActive: Bool = false) -> BtnTabFooter {
        
        let widthOfBtn: CGFloat = parentController.view.frame.size.width / 3
        //print("widthOfBtn: \(widthOfBtn)")
        
        let btnTabFooter = BtnTabFooter(iconName: iconName, btnTabFooterPosition: btnTabFooterPosition)
        //btnTabProfile.backgroundColor = .green
        btnTabFooter.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(btnTabFooter)
        btnTabFooter.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnTabFooter.widthAnchor.constraint(equalToConstant: widthOfBtn).isActive = true
        btnTabFooter.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        
        switch(btnTabFooterPosition){
        case .LESSONS:
            btnTabFooter.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: -CGFloat(parentController.view.frame.size.width / 3)).isActive = true
            break
        case .PURCHASES:
            btnTabFooter.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
            break
        case .PROFILE:
            btnTabFooter.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: CGFloat(parentController.view.frame.size.width / 3)).isActive = true
            break
        }
        
        btnTabFooter.setIsActive(isActive)
        
        return btnTabFooter
    }
    
}
