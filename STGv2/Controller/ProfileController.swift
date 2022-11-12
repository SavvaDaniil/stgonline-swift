//
//  ProfileController.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit


class ProfileController : UIViewController, LogoutCallbackDelegate, JsonAnswerStatusCallbackDelegate, TryAgainDelegate {
    
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var logoutCallbackDelegate: LogoutCallbackDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Это окно ProfileController"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var topNavBar: TopNavBar?
    private var loadingView: LoadingView?
    private var errorView: ErrorView?
    private var profileView: ProfileView?
    
    private let userFacade: UserFacade = UserFacade()
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        /*
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        */
        
        
        let topNavBarFactory = TopNavBarFactory()
        topNavBar = topNavBarFactory.createWithLogoutBtn(parentController: self, titleText: "Профиль", logoutCallbackDelegate: self)
        
        let loadingViewFactory = LoadingViewFactory()
        loadingView = loadingViewFactory.create(parentController: self, topView: topNavBar)
        loadingView?.setIsActive(false)
        
        let errorViewFactory = ErrorViewFactory()
        errorView = errorViewFactory.create(parentController: self, topView: topNavBar, titleError: "", tryAgainDelegate: self)
        errorView?.setIsActive(false)
        
        profileView = ProfileView(context: context, parentController: self)
        self.view.addSubview(profileView!)
        profileView!.translatesAutoresizingMaskIntoConstraints = false
        profileView!.topAnchor.constraint(equalTo: topNavBar!.bottomAnchor).isActive = true
        profileView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        profileView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        profileView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    public func setupForCreate(logoutCallbackDelegate: LogoutCallbackDelegate){
        self.logoutCallbackDelegate = logoutCallbackDelegate
    }
    
    public func setupForInit(){
        self.setStateLoading()
        let jwt: String? = self.userFacade.getJwt(context: self.context)
        if jwt == nil {
            
            return
        }
        self.userFacade.profileGet(jsonAnswerStatusCallbackDelegate: self, jwt: jwt!)
    }
    
    private func setStateError(titleTextError: String){
        self.loadingView?.isHidden = true
        self.errorView?.isHidden = false
        self.errorView?.setTitleErrorText(titleError: titleTextError)
        self.profileView?.isHidden = true
        self.topNavBar?.setIsActiveBtnLogout(value: false)
    }
    private func setStateLoading(){
        self.loadingView?.isHidden = false
        self.errorView?.isHidden = true
        self.profileView?.isHidden = true
        self.topNavBar?.setIsActiveBtnLogout(value: false)
    }
    private func setStateReady(){
        self.loadingView?.isHidden = true
        self.errorView?.isHidden = true
        self.errorView?.setTitleErrorText(titleError: "")
        self.profileView?.isHidden = false
        self.topNavBar?.setIsActiveBtnLogout(value: true)
    }
    
    internal func tryAgain() {
        self.setupForInit()
    }
    
    
    internal func logoutCallback() {
        //print("logoutCallback")
        let userFacade: UserFacade = UserFacade()
        if !userFacade.logout(context: self.context) {
            print("Не удалалось выйти")
            return
        }
        
        self.logoutCallbackDelegate?.logoutCallback()
    }
    
    internal func jsonAnswerStatusCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool = false) {
        self.isLoading = false
        if isNetError {
            self.setStateError(titleTextError:"Ошибка сети")
            return
        }
        
        if jsonAnswerStatus == nil {
            self.setStateError(titleTextError:"Ошибка на сервере")
            return
        }
        
        if jsonAnswerStatus?.status == "success" && jsonAnswerStatus?.userProfileViewModel != nil {
            self.profileView?.profileFillData(username: jsonAnswerStatus?.userProfileViewModel?.username ?? "")
            self.setStateReady()
        } else {
            self.setStateError(titleTextError:"Неизвестная ошибка на сервере")
        }
    }
}
