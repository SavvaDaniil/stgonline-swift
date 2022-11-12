//
//  SubscriptionLiteView.swift
//  STGv2
//
//  Created by Daniil Savva on 04.11.2022.
//

import UIKit

class SubscriptionLiteView : UIButton {
    
    private var subscriptionLiteViewModel: SubscriptionLiteViewModel
    private var isActive: Bool = false
    private let nameLabel: UILabel = UILabel(frame: CGRect())
    private let priceLabel: UILabel = UILabel(frame: CGRect())
    
    required init(subscriptionLiteViewModel: SubscriptionLiteViewModel, isActive: Bool){
        self.subscriptionLiteViewModel = subscriptionLiteViewModel
        self.isActive = isActive
        super.init(frame: CGRect())
        
        self.layer.borderWidth = 2
        self.layer.borderColor = GlobalVariables.grayColor.cgColor
        self.layer.cornerRadius = 12
        
        nameLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        nameLabel.textColor = .black
        nameLabel.text = subscriptionLiteViewModel.name ?? "<ошибка>"
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        priceLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
        priceLabel.text = subscriptionLiteViewModel.price_str ?? "<ошибка>"
        self.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        self.setActive(value: isActive)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setActive(value: Bool){
        self.isActive = value
        if value {
            self.backgroundColor = GlobalVariables.activeColor
        } else {
            self.backgroundColor = GlobalVariables.grayColor
        }
    }
    
    public func getId() -> Int {
        return self.subscriptionLiteViewModel.id
    }
}
