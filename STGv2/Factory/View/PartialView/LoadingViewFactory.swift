//
//  LoadingViewFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

class LoadingViewFactory {
    
    public func create(parentController: UIViewController, topView: UIView?) -> LoadingView {
        let loadingView: LoadingView = LoadingView()
        
        parentController.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        if topView == nil {
            loadingView.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
        } else {
            loadingView.topAnchor.constraint(equalTo: topView!.bottomAnchor).isActive = true
        }
        loadingView.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        
        return loadingView
    }
}
