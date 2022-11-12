//
//  PurchasePreviewsView.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

import UIKit

class PurchaseLitesView : UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var parentController: UIViewController
    private var purchaseLitesTable : UITableView?
    private let titleNoPurchases: UILabel
    
    required init(parentController: UIViewController){
        self.parentController = parentController
        titleNoPurchases = UILabel(frame: CGRect())
        super.init(frame: CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        purchaseLitesTable = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        purchaseLitesTable!.translatesAutoresizingMaskIntoConstraints = false
        purchaseLitesTable!.backgroundColor = UIColor(white: 1, alpha: 0)
        purchaseLitesTable!.separatorStyle = .none
        //purchaseLitesTable!.separatorStyle = .singleLine
        purchaseLitesTable!.bounces = false
        purchaseLitesTable!.rowHeight = 40
        self.addSubview(purchaseLitesTable!)
        purchaseLitesTable!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        purchaseLitesTable!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        purchaseLitesTable!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        purchaseLitesTable!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        purchaseLitesTable!.delegate = self
        purchaseLitesTable!.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updatePurchaseLitesTable(){
        print("PurchaseLitesView updatePurchaseLitesTable")
        self.purchaseLitesTable?.reloadData()
        if GlobalVariables.purchaseViewModels.count == 0 {
            self.purchaseLitesTable?.isHidden = true
            self.titleNoPurchases.isHidden = false
        } else {
            self.purchaseLitesTable?.isHidden = false
            self.titleNoPurchases.isHidden = true
        }
    }
    
}


extension PurchaseLitesView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalVariables.purchaseViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PurchaseLiteTableViewCell(parentView: self.parentController.view, purchaseViewModel: GlobalVariables.purchaseViewModels[indexPath.row])
        
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "purchaseLiteTableViewCell")
        cell.backgroundColor = UIColor(white: 1, alpha: 0)
        
        //cell.textLabel?.textColor = .white
        //cell.textLabel?.text = "#" + String(GlobalVariables.purchaseAbstractViewModels[indexPath.row].payment_id) + " " + (GlobalVariables.purchaseAbstractViewModels[indexPath.row].name ?? "")
        //cell.textLabel?.description =
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let purchaseAboutController: PurchaseAboutController = PurchaseAboutController()
        purchaseAboutController.setPurchaseAbstract(purchaseViewModel: GlobalVariables.purchaseViewModels[indexPath.row])
        self.parentController.presentFromRight(vc: purchaseAboutController)
    }
    
    
}
