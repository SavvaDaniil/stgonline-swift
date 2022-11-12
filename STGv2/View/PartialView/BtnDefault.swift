//
//  BtnDefault.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//

import UIKit

class BtnDefault : UIButton {
    
    private let titleLabelOfBtn = UILabel(frame: CGRect())
    
    required init(titleText: String, fontSize: CGFloat = 14){
        super.init(frame: CGRect())
        
        self.backgroundColor = GlobalVariables.activeColor
        self.layer.cornerRadius = 12
        
        titleLabelOfBtn.textColor = .black
        titleLabelOfBtn.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: fontSize)
        titleLabelOfBtn.textAlignment = .center
        titleLabelOfBtn.text = titleText
        
        self.addSubview(titleLabelOfBtn)
        titleLabelOfBtn.translatesAutoresizingMaskIntoConstraints = false
        titleLabelOfBtn.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabelOfBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabelOfBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabelOfBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitleText(titleText: String){
        self.titleLabelOfBtn.text = titleText
    }
    
}
