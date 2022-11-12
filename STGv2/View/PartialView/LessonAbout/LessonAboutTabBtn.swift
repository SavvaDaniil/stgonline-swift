//
//  LessonAboutTabBtn.swift
//  STGv2
//
//  Created by Daniil Savva on 02.11.2022.
//

import UIKit

class LessonAboutTabBtn : UIButton {
    
    private var isActive: Bool = false
    private let titleLabelText: UILabel = UILabel(frame: CGRect())
    private let underlineView = UIView(frame: CGRect())
    private var lessonAboutTabState: LessonAboutTabState
    
    required init(parentController: UIViewController, titleText: String, lessonAboutTabState: LessonAboutTabState, isActive: Bool = false){
        self.lessonAboutTabState = lessonAboutTabState
        super.init(frame: CGRect())
        
        titleLabelText.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        titleLabelText.text = titleText
        titleLabelText.textColor = .white
        self.addSubview(titleLabelText)
        titleLabelText.translatesAutoresizingMaskIntoConstraints = false
        titleLabelText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabelText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        underlineView.backgroundColor = .white
        underlineView.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        underlineView.layer.borderWidth = 1
        self.addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        underlineView.widthAnchor.constraint(equalToConstant: CGFloat(parentController.view.frame.width / 3)).isActive = true
        underlineView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.setIsActive(isActive: isActive)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setIsActive(isActive: Bool){
        self.isActive = isActive
        if isActive {
            titleLabelText.textColor = .white
            underlineView.backgroundColor = .white
            underlineView.isHidden = false
        } else {
            titleLabelText.textColor = GlobalVariables.grayColor
            underlineView.backgroundColor = GlobalVariables.grayColor
            underlineView.isHidden = true
        }
    }
    
    public func getIsActive() -> Bool {
        return self.isActive
    }
    
    public func getLessonAboutTabState() -> LessonAboutTabState {
        return self.lessonAboutTabState
    }
}
