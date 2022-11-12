//
//  TopNavBarFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

class TopNavBarFactory {
    
    public func create(parentController: UIViewController, titleText: String) -> TopNavBar {
        
        let topNavBar: TopNavBar = TopNavBar(titleText: titleText)
        
        parentController.view.addSubview(topNavBar)
        topNavBar.translatesAutoresizingMaskIntoConstraints = false
        topNavBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        topNavBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        topNavBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        topNavBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return topNavBar
    }
    
    public func createWithBackBtn(parentController: UIViewController, titleText: String) -> TopNavBar {
        
        let topNavBar: TopNavBar = TopNavBar(titleText: titleText)
        topNavBar.createBackBtn(parentController: parentController)
        
        parentController.view.addSubview(topNavBar)
        topNavBar.translatesAutoresizingMaskIntoConstraints = false
        topNavBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        topNavBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        topNavBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        topNavBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return topNavBar
    }
    
    public func createWithLogoutBtn(parentController: UIViewController, titleText: String, logoutCallbackDelegate: LogoutCallbackDelegate) -> TopNavBar {
        
        let topNavBar: TopNavBar = TopNavBar(titleText: titleText)
        topNavBar.createLogoutBtn(parentController: parentController, logoutCallbackDelegate: logoutCallbackDelegate)
        
        parentController.view.addSubview(topNavBar)
        topNavBar.translatesAutoresizingMaskIntoConstraints = false
        topNavBar.topAnchor.constraint(equalTo: parentController.view.safeTopAnchor).isActive = true
        topNavBar.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        topNavBar.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        topNavBar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return topNavBar
    }
    
}
