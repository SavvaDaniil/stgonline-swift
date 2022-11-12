//
//  PurchaseLiteTableViewCell.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

import UIKit

class PurchaseLiteTableViewCell : UITableViewCell {
    
    private var purchaseViewModel: PurchaseViewModel
    
    private let steYBetweenDescription = 2
    private var btnStateOfPurchase: UIButton?
    private var stateOfPurchase: UILabel?
    
    required init(parentView: UIView, purchaseViewModel: PurchaseViewModel
    ){
        self.purchaseViewModel = purchaseViewModel
        
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellPurchaseLite")
        contentView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        
        let labelTitle: UILabel = UILabel(frame: CGRect())
        labelTitle.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 14)
        labelTitle.textColor = .white
        labelTitle.text = "#" + String(purchaseViewModel.payment_id) + " " + (purchaseViewModel.name ?? "")
        self.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: CGFloat(parentView.frame.width * 0.7)).isActive = true
        
        
        self.btnStateOfPurchase = UIButton(frame: CGRect())
        self.btnStateOfPurchase?.layer.cornerRadius = 4
        
        self.stateOfPurchase = UILabel(frame: CGRect())
        self.stateOfPurchase?.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.stateOfPurchase?.textColor = .black
        self.btnStateOfPurchase!.addSubview(self.stateOfPurchase!)
        self.stateOfPurchase!.translatesAutoresizingMaskIntoConstraints = false
        self.stateOfPurchase!.centerYAnchor.constraint(equalTo: self.btnStateOfPurchase!.centerYAnchor).isActive = true
        self.stateOfPurchase!.centerXAnchor.constraint(equalTo: self.btnStateOfPurchase!.centerXAnchor).isActive = true
        
        
        self.addSubview(self.btnStateOfPurchase!)
        btnStateOfPurchase!.translatesAutoresizingMaskIntoConstraints = false
        btnStateOfPurchase!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnStateOfPurchase!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        btnStateOfPurchase!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnStateOfPurchase!.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //print("purchaseAbstractViewModel.is_expired: \(purchaseAbstractViewModel.is_expired)")
        if purchaseViewModel.is_expired {
            self.btnStateOfPurchase?.backgroundColor = .red
            self.stateOfPurchase!.text = "исч"
        } else if purchaseViewModel.date_of_activation == nil {
            self.btnStateOfPurchase?.backgroundColor = .gray
            self.stateOfPurchase!.text = "не акт"
        } else {
            self.btnStateOfPurchase?.backgroundColor = .gray
            self.stateOfPurchase!.text = "акт"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

