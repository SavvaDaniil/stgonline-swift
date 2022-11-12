//
//  FooterLoadingPreviewsTableView.swift
//  STGv2
//
//  Created by Daniil Savva on 06.11.2022.
//

import UIKit

enum FooterLessonPreviewsTableState : Int {
    case READY = 0
    case LOADING = 1
    case ERROR = 2
}

class FooterLessonPreviewsTableView : UIView {
    
    private var footerLessonPreviewsTableDelegate: FooterLessonPreviewsTableDelegate
    
    private let messageLoading = UILabel(frame: CGRect())
    
    private let messageError = UILabel(frame: CGRect())
    private let btnTryAgain = BtnDefault(titleText: "Еще раз", fontSize: 12)
    private var footerLessonPreviewsTableState: FooterLessonPreviewsTableState = .READY
    
    required init(parentController: UIViewController, footerLessonPreviewsTableDelegate: FooterLessonPreviewsTableDelegate){
        self.footerLessonPreviewsTableDelegate = footerLessonPreviewsTableDelegate
        super.init(frame: CGRect(x: 0, y: 0, width: parentController.view.frame.width, height: 50))
        //self.backgroundColor = .blue
        
        messageLoading.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        messageLoading.text = "Идет загрузка..."
        messageLoading.textColor = .white
        self.addSubview(messageLoading)
        messageLoading.translatesAutoresizingMaskIntoConstraints = false
        messageLoading.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLoading.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        messageError.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        messageError.text = "Ошибка сети"
        messageError.textAlignment = .center
        messageError.textColor = .white
        self.addSubview(messageError)
        messageError.translatesAutoresizingMaskIntoConstraints = false
        messageError.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        messageError.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageError.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        messageError.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.addSubview(btnTryAgain)
        btnTryAgain.translatesAutoresizingMaskIntoConstraints = false
        btnTryAgain.topAnchor.constraint(equalTo: messageError.bottomAnchor, constant: 8).isActive = true
        btnTryAgain.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnTryAgain.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnTryAgain.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnTryAgain.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        
        //self.footerStateListener()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setFooterState(footerLessonPreviewsTableState: FooterLessonPreviewsTableState){
        self.footerLessonPreviewsTableState = footerLessonPreviewsTableState
        self.footerStateListener()
    }
    
    private func footerStateListener(){
        switch self.footerLessonPreviewsTableState {
            
        case .READY:
            self.messageLoading.isHidden = true
            self.messageError.isHidden = true
            self.btnTryAgain.isHidden = true
        case .LOADING:
            self.messageLoading.isHidden = false
            self.messageError.isHidden = true
            self.btnTryAgain.isHidden = true
        case .ERROR:
            self.messageLoading.isHidden = true
            self.messageError.isHidden = false
            self.btnTryAgain.isHidden = false
        }
    }
    
    @objc
    private func tryAgain(){
        self.footerLessonPreviewsTableDelegate.tryAgain()
    }
}
