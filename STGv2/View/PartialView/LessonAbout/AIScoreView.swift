//
//  AiScoreView.swift
//  STGv2
//
//  Created by Daniil Savva on 03.11.2022.
//

import UIKit

class AIScoreView : UIView {
    
    required init(score: Int, isActive: Bool = true){
        super.init(frame: CGRect())
        
        //self.backgroundColor = GlobalVariables.grayColor
        self.setActive(value: isActive)
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        
        let aiScore = UILabel(frame: CGRect())
        aiScore.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        aiScore.textColor = .black
        aiScore.text = "\(score)%"
        self.addSubview(aiScore)
        aiScore.translatesAutoresizingMaskIntoConstraints = false
        aiScore.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        aiScore.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        aiScore.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setActive(value: Bool){
        if value {
            self.backgroundColor = GlobalVariables.grayColor
        } else {
            self.backgroundColor = GlobalVariables.grayColorNotActive
        }
    }
    
    
}
