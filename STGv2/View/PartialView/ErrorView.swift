//
//  ErrorView.swift
//  STGv2
//
//  Created by Daniil Savva on 29.10.2022.
//

import UIKit


class ErrorView : UIView {
    
    private var tryAgainDelegate: TryAgainDelegate
    
    private let titleLabel: UILabel = UILabel()
    private let btnTryAgain: BtnDefault = BtnDefault(titleText: "Еще раз")
    
    required init(titleError: String, tryAgainDelegate: TryAgainDelegate){
        self.tryAgainDelegate = tryAgainDelegate
        super.init(frame: CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = titleError
        titleLabel.textColor = GlobalVariables.activeColor
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(btnTryAgain)
        btnTryAgain.translatesAutoresizingMaskIntoConstraints = false
        btnTryAgain.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        btnTryAgain.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnTryAgain.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btnTryAgain.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnTryAgain.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setIsActive(_ isActive: Bool){
        self.isHidden = !isActive
    }
    
    public func getIsActive() -> Bool {
        return !self.isHidden
    }
    
    public func setTitleErrorText(titleError: String) {
        self.titleLabel.text = titleError
    }
    
    @objc
    private func tryAgain(){
        self.tryAgainDelegate.tryAgain()
    }
}
