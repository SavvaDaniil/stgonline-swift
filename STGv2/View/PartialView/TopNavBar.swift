//
//  TopNavBar.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

class TopNavBar : UIView {
    
    private var btnBack: UIButton?
    private var btnLogout: UIButton?
    private var logoutCallbackDelegate: LogoutCallbackDelegate?
    private var titleLabel: UILabel
    private var parentController: UIViewController?
    
    required init(titleText: String) {
        
        titleLabel = UILabel(frame: CGRect())
        titleLabel.text = titleText
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        titleLabel.textAlignment = .center
        
        super.init(frame: CGRect())
        
        self.backgroundColor = .black
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    public func createBackBtn(parentController: UIViewController) -> () {
        if btnBack != nil{
            return
        }
        self.parentController = parentController
        
        btnBack = UIButton(frame: CGRect())
        btnBack!.translatesAutoresizingMaskIntoConstraints = false
        let iconBackImage = UIImageView(image: UIImage(named: "iconBack"))
        iconBackImage.translatesAutoresizingMaskIntoConstraints = false
        btnBack!.addSubview(iconBackImage)
        iconBackImage.topAnchor.constraint(equalTo: btnBack!.topAnchor).isActive = true
        iconBackImage.bottomAnchor.constraint(equalTo: btnBack!.bottomAnchor).isActive = true
        iconBackImage.leadingAnchor.constraint(equalTo: btnBack!.leadingAnchor).isActive = true
        iconBackImage.trailingAnchor.constraint(equalTo: btnBack!.trailingAnchor).isActive = true
        
        self.addSubview(btnBack!)
        btnBack!.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        btnBack!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        btnBack!.heightAnchor.constraint(equalToConstant: 28).isActive = true
        btnBack!.widthAnchor.constraint(equalToConstant: 28).isActive = true
        btnBack?.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
    }
    
    public func createLogoutBtn(parentController: UIViewController, logoutCallbackDelegate: LogoutCallbackDelegate) -> () {
        if btnLogout != nil{
            return
        }
        self.parentController = parentController
        self.logoutCallbackDelegate = logoutCallbackDelegate
        
        btnLogout = UIButton(frame: CGRect())
        btnLogout!.translatesAutoresizingMaskIntoConstraints = false
        let iconLogoutImage = UIImageView(image: UIImage(named: "logout"))
        iconLogoutImage.translatesAutoresizingMaskIntoConstraints = false
        btnLogout!.addSubview(iconLogoutImage)
        iconLogoutImage.topAnchor.constraint(equalTo: btnLogout!.topAnchor).isActive = true
        iconLogoutImage.bottomAnchor.constraint(equalTo: btnLogout!.bottomAnchor).isActive = true
        iconLogoutImage.leadingAnchor.constraint(equalTo: btnLogout!.leadingAnchor).isActive = true
        iconLogoutImage.trailingAnchor.constraint(equalTo: btnLogout!.trailingAnchor).isActive = true
        
        self.addSubview(btnLogout!)
        btnLogout!.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        btnLogout!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        btnLogout!.heightAnchor.constraint(equalToConstant: 28).isActive = true
        btnLogout!.widthAnchor.constraint(equalToConstant: 28).isActive = true
        btnLogout!.addTarget(self, action: #selector(logoutPrepare), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitle(title: String){
        self.titleLabel.text = title
    }
    
    @objc
    private func closeViewController(){
        /*
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.parentController?.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.parentController?.dismiss(animated: true)
        */
        self.parentController?.dissmissToRight()
    }
    
    @objc
    private func logoutPrepare(){
        if self.logoutCallbackDelegate == nil {
            
        }
        print("logoutPrepare")
        
        let alert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            self.logoutCallbackDelegate?.logoutCallback()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .destructive, handler: nil))
        self.parentController?.present(alert, animated: true, completion: nil)
    }
    
    public func setIsActiveBtnLogout(value: Bool){
        if self.btnLogout == nil {
            return
        }
        self.btnLogout!.isHidden = !value
    }
}
