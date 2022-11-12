//
//  LoadingView.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit


class LoadingView : UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Идёт загрузка..."
        label.textColor = GlobalVariables.activeColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isActive: Bool = false
    
    required init(){
        super.init(frame: CGRect())
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setIsActive(_ isActive: Bool){
        self.isHidden = !isActive
        self.isActive = isActive
    }
    
    public func getIsActive() -> Bool {
        return self.isActive
    }
}
