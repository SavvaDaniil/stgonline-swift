//
//  ControllerExtension.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit
import Foundation


extension UIViewController: UITextFieldDelegate {
    
    internal func setDefaultBackground(){
        view.backgroundColor = .black
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_repeat")!)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
    internal func addViewFullScreen(viewForAdd: UIView, topView: UIView? = nil){
        self.view.addSubview(viewForAdd)
        viewForAdd.translatesAutoresizingMaskIntoConstraints = false
        if topView != nil {
            viewForAdd.topAnchor.constraint(equalTo: topView!.bottomAnchor).isActive = true
        } else {
            viewForAdd.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
        viewForAdd.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        viewForAdd.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        viewForAdd.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    public func presentFromRight(vc: UIViewController){
        vc.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(vc, animated: false, completion: nil)
    }
    
    public func dissmissToRight(){
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.dismiss(animated: true)
    }
}
