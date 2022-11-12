//
//  AIScoreLabel.swift
//  STGv2
//
//  Created by Daniil Savva on 04.11.2022.
//

import UIKit

class AIScoreLabel : UILabel {
    
    required init(titleText: String){
        super.init(frame: CGRect())
        
        self.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.textColor = .white
        self.textAlignment = .center
        self.text = titleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
