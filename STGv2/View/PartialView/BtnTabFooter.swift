//
//  BtnTabFooter.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import Foundation
import UIKit

class BtnTabFooter : UIButton {
    
    private var iconName: String
    private var btnTabFooterPosition: BtnTabFooterPosition
    private var isActive: Bool = false
    private let iconImg = UIImageView(frame: CGRect())
    
    required init(iconName: String, btnTabFooterPosition: BtnTabFooterPosition){
        self.iconName = iconName
        self.btnTabFooterPosition = btnTabFooterPosition
        //print("self.iconName: \(self.iconName)-not-active")
        super.init(frame: CGRect())
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        
        //let iconImg = UIImageView(frame: CGRect())
        iconImg.image = UIImage(named: "\(self.iconName)-not-active")
        self.addSubview(iconImg)
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        iconImg.heightAnchor.constraint(equalToConstant: 35).isActive = true
        iconImg.widthAnchor.constraint(equalToConstant: 35).isActive = true
        iconImg.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setIsActive(_ isActive: Bool){
        if isActive {
            self.iconImg.image = UIImage(named: "\(self.iconName)-active")
        } else {
            self.iconImg.image = UIImage(named: "\(self.iconName)-not-active")
        }
        self.isActive = isActive
    }
    
    public func getIsActive() -> Bool {
        return self.isActive
    }
    
    public func getBtnTabFooterPosition() -> BtnTabFooterPosition {
        return self.btnTabFooterPosition
    }
}
