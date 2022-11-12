//
//  ErrorViewFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 29.10.2022.
//

import UIKit

class ErrorViewFactory : UIView {
    
    public func create(parentController: UIViewController, topView: UIView?, titleError: String, tryAgainDelegate: TryAgainDelegate) -> ErrorView {
        let errorView: ErrorView = ErrorView(titleError: titleError, tryAgainDelegate: tryAgainDelegate)
        
        parentController.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        if topView == nil {
            errorView.topAnchor.constraint(equalTo: parentController.view.topAnchor).isActive = true
        } else {
            errorView.topAnchor.constraint(equalTo: topView!.bottomAnchor).isActive = true
        }
        errorView.bottomAnchor.constraint(equalTo: parentController.view.bottomAnchor).isActive = true
        errorView.leadingAnchor.constraint(equalTo: parentController.view.leadingAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: parentController.view.trailingAnchor).isActive = true
        
        return errorView
    }
}
