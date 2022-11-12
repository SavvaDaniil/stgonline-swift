//
//  AuthController.swift
//  STGv2
//
//  Created by Daniil Savva on 27.10.2022.
//

import UIKit

class AuthenticationController : UIViewController, ChangeAuthStateDelegate, AuthLoginCallback {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var authCallbackDelegate: AuthCallbackDelegate?
    private var authenticationViewState: AuthenticationViewState = .LOGIN
    private var topNavBar: TopNavBar?
    private var loginView: LoginView?
    private var registrationView: RegistrationView?
    private var forgetView: ForgetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDefaultBackground()
        
        //view.translatesAutoresizingMaskIntoConstraints = false
        
        loginView = LoginView(context: context, changeAuthStateDelegate: self, authLoginCallback: self)
        registrationView = RegistrationView(context: context, changeAuthStateDelegate: self, authLoginCallback: self)
        forgetView = ForgetView(context: context, changeAuthStateDelegate: self, authLoginCallback: self)
        
        let topNavBarFactory = TopNavBarFactory()
        topNavBar = topNavBarFactory.createWithBackBtn(parentController: self, titleText: "Аутентификация")
        
        self.addViewFullScreen(viewForAdd: loginView!, topView: topNavBar!)
        self.addViewFullScreen(viewForAdd: registrationView!, topView: topNavBar!)
        self.addViewFullScreen(viewForAdd: forgetView!, topView: topNavBar!)
        //loginView!.isHidden = false
        registrationView!.isHidden = true
        forgetView!.isHidden = true
        
        //topNavBar!.setTitle(title: "Забыли пароль")
    }
    
    public func prepare(authCallbackDelegate: AuthCallbackDelegate){
        self.authCallbackDelegate = authCallbackDelegate
    }
    
    internal func change(authenticationViewState: AuthenticationViewState) {
        switch authenticationViewState {
            
        case .LOGIN:
            registrationView!.isHidden = true
            loginView!.isHidden = false
            forgetView!.isHidden = true
            topNavBar!.setTitle(title: "Аутентификация")
        case .REGISTRATION:
            loginView!.isHidden = true
            registrationView!.isHidden = false
            forgetView!.isHidden = true
            topNavBar!.setTitle(title: "Регистрация")
        case .FORGET:
            loginView!.isHidden = true
            registrationView!.isHidden = true
            forgetView!.isHidden = false
            topNavBar!.setTitle(title: "Забыли пароль")
            break
        }
    }
    
    internal func loginSuccessfull() {
        self.authCallbackDelegate?.callbackAfterChangeAuth()
        self.dissmissToRight()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
