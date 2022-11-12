//
//  ViewController.swift
//  STGv2
//
//  Created by Daniil Savva on 24.10.2022.
//

import UIKit

class ViewContainerController: UIViewController, LogoutCallbackDelegate, AuthCallbackDelegate {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Это окно Главной"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var btnTabFooters : [BtnTabFooter] = []
    
    private let tabFooterMenu: UIView = UIView(frame: CGRect())
    private var controllers: [UIViewController] = []
    //private let coursesController = CoursesController()
    private let lessonsController = LessonsController()
    private let purchasesController = PurchasesController()
    private let profileController = ProfileController()
    
    
    private let userFacade: UserFacade = UserFacade()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("ViewContainerController launched")
        profileController.setupForCreate(logoutCallbackDelegate: self)
        
        self.setDefaultBackground()
        
        
        
        self.view.addSubview(tabFooterMenu)
        tabFooterMenu.backgroundColor = .black
        tabFooterMenu.translatesAutoresizingMaskIntoConstraints = false
        tabFooterMenu.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabFooterMenu.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabFooterMenu.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tabFooterMenu.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        let btnTabFooterFactory = BtnTabFooterFactory()
        let btnTabLessons = btnTabFooterFactory.create(parentController: self,parentView: tabFooterMenu, iconName: "icon-home", btnTabFooterPosition: .LESSONS, isActive: true)
        btnTabLessons.addTarget(self, action: #selector(changeTabByBtn), for: .touchUpInside)
        btnTabFooters.append(btnTabLessons)
        
        
        let btnTabPurchases = btnTabFooterFactory.create(parentController: self,parentView: tabFooterMenu, iconName: "icon-purchases", btnTabFooterPosition: .PURCHASES)
        btnTabPurchases.addTarget(self, action: #selector(changeTabByBtn), for: .touchUpInside)
        btnTabFooters.append(btnTabPurchases)
        
        let btnTabProfile = btnTabFooterFactory.create(parentController: self,parentView: tabFooterMenu, iconName: "icon-user", btnTabFooterPosition: .PROFILE)
        btnTabProfile.addTarget(self, action: #selector(changeTabByBtn), for: .touchUpInside)
        btnTabFooters.append(btnTabProfile)
        
        
        self.addControllerAndSetConstraints(lessonsController, isHidden: false)
        controllers.append(lessonsController)
        //self.addControllerAndSetConstraints(coursesController)
        //controllers.append(coursesController)
        self.addControllerAndSetConstraints(purchasesController)
        controllers.append(purchasesController)
        self.addControllerAndSetConstraints(profileController)
        controllers.append(profileController)
        
    }

    
    @objc
    private func changeTabByBtn(_ senderBtn: BtnTabFooter) -> (){
        self.changeTab(btnTabFooterPosition: senderBtn.getBtnTabFooterPosition())
    }
    
    private func changeTab(btnTabFooterPosition: BtnTabFooterPosition){
        
        if btnTabFooterPosition == .PROFILE || btnTabFooterPosition == .PURCHASES {
            if !userFacade.isAuth(context: self.context) {
                let authController = AuthenticationController()
                authController.modalPresentationStyle = .fullScreen
                //authController.modalTransitionStyle = .crossDissolve
                authController.prepare(authCallbackDelegate: self)
                self.presentFromRight(vc: authController)
                return
            }
        }
        
        for controller in self.controllers {
            controller.view.isHidden = true
        }
        
        for btnTabFooter in self.btnTabFooters {
            btnTabFooter.setIsActive(false)
            
            if btnTabFooter.getBtnTabFooterPosition() == btnTabFooterPosition {
                btnTabFooter.setIsActive(true)
                
                //print(senderBtn.getBtnTabFooterPosition().rawValue)
                controllers[btnTabFooterPosition.rawValue].view.isHidden = false
                
                //нужна загрузка в контроллерах после переключения!
                if btnTabFooterPosition == .PURCHASES {
                    self.purchasesController.setupForInit()
                }
                if btnTabFooterPosition == .PROFILE {
                    self.profileController.setupForInit()
                }
                
            }
        }
    }
    
    private func addControllerAndSetConstraints(_ controller: UIViewController, isHidden: Bool = true){
        view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
        
        //controller.view.topAnchor.constraint(equalTo: navBarMainView!.bottomAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: tabFooterMenu.topAnchor).isActive = true
        
        controller.view.isHidden = isHidden
    }
    
    internal func logoutCallback() {
        self.changeTab(btnTabFooterPosition: .LESSONS)
    }
    internal func callbackAfterChangeAuth() {
        self.lessonsController.setup()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}

