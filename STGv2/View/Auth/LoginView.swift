//
//  LoginView.swift
//  STGv2
//
//  Created by Daniil Savva on 27.10.2022.
//

import CoreData
import UIKit


class LoginView : UIView, JsonAnswerStatusCallbackDelegate {
    
    private var context: NSManagedObjectContext
    private var changeAuthStateDelegate: ChangeAuthStateDelegate
    private var authLoginCallback: AuthLoginCallback
    
    private let usernameLabel: UILabel = UILabel()
    private let usernameField: UITextFieldDefault = UITextFieldDefault("", .emailAddress)
    
    private let passwordLabel: UILabel = UILabel()
    private let passwordField: UITextFieldDefault = UITextFieldDefault("", .default, true)
    
    private let warningLabel: UILabel = UILabel()
    
    private let btnLogin = BtnDefault(titleText: "Войти")
    
    private let labelToRegistratrion = UILabel()
    private let labelToForget = UILabel()
    private let btnToRegistratrion = BtnDefault(titleText: "Регистрация", fontSize: 12)
    private let btnToForget = BtnDefault(titleText: "Восстановить", fontSize: 12)
    
    private let userFacade: UserFacade = UserFacade()
    private var isLoading: Bool = false
    
    required init(context: NSManagedObjectContext, changeAuthStateDelegate: ChangeAuthStateDelegate, authLoginCallback: AuthLoginCallback){
        self.context = context
        self.changeAuthStateDelegate = changeAuthStateDelegate
        self.authLoginCallback = authLoginCallback
        super.init(frame: CGRect())
        //let inputFormGroupFactory = InputFormGroupFactory()
        
        self.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordField.addTarget(self, action: #selector(clearWarning), for: .editingChanged)
        passwordField.delegate = self
        
        
        passwordLabel.text = "Пароль"
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        passwordLabel.textAlignment = .left
        self.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -10).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.bottomAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: -20).isActive = true
        usernameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        usernameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        usernameField.addTarget(self, action: #selector(clearWarning), for: .editingChanged)
        usernameField.delegate = self
        
        
        usernameLabel.text = "Электронная почта"
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        usernameLabel.textAlignment = .left
        self.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.bottomAnchor.constraint(equalTo: usernameField.topAnchor, constant: -10).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        warningLabel.text = ""
        warningLabel.textColor = GlobalVariables.activeColor
        warningLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        warningLabel.textAlignment = .center
        self.addSubview(warningLabel)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24).isActive = true
        warningLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        warningLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 20).isActive = true
        btnLogin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        btnLogin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnLogin.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        
        labelToRegistratrion.text = "У меня нет аккаунта"
        labelToRegistratrion.textColor = GlobalVariables.grayColor
        labelToRegistratrion.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        labelToRegistratrion.textAlignment = .right
        self.addSubview(labelToRegistratrion)
        labelToRegistratrion.translatesAutoresizingMaskIntoConstraints = false
        labelToRegistratrion.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 60).isActive = true
        labelToRegistratrion.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        labelToRegistratrion.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        labelToRegistratrion.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(btnToRegistratrion)
        btnToRegistratrion.translatesAutoresizingMaskIntoConstraints = false
        btnToRegistratrion.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 55).isActive = true
        btnToRegistratrion.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        btnToRegistratrion.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnToRegistratrion.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnToRegistratrion.addTarget(self, action: #selector(toRegistation), for: .touchUpInside)
        
        
        
        labelToForget.text = "Забыли пароль"
        labelToForget.textColor = GlobalVariables.grayColor
        labelToForget.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        labelToForget.textAlignment = .right
        self.addSubview(labelToForget)
        labelToForget.translatesAutoresizingMaskIntoConstraints = false
        labelToForget.topAnchor.constraint(equalTo: labelToRegistratrion.bottomAnchor, constant: 30).isActive = true
        labelToForget.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        labelToForget.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        labelToForget.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(btnToForget)
        btnToForget.translatesAutoresizingMaskIntoConstraints = false
        btnToForget.topAnchor.constraint(equalTo: btnToRegistratrion.bottomAnchor, constant: 20).isActive = true
        btnToForget.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        btnToForget.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnToForget.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnToForget.addTarget(self, action: #selector(toForget), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func toRegistation(){
        self.changeAuthStateDelegate.change(authenticationViewState: .REGISTRATION)
    }
    
    @objc
    private func toForget(){
        self.changeAuthStateDelegate.change(authenticationViewState: .FORGET)
    }
    
    @objc
    private func clearWarning(){
        warningLabel.text = ""
    }
    
    @objc
    private func login(){
        if self.isLoading {
            return
        }
        self.clearWarning()
        let username: String = usernameField.text ?? ""
        let password: String = passwordField.text ?? ""
        if username == "" || password == "" {
            warningLabel.text = "Оба поля обязательны для заполнения"
            return
        }
        
        let userLoginDTO: UserLoginDTO = UserLoginDTO(username: username, password: password)
        self.userFacade.login(jsonAnswerStatusCallbackDelegate: self, userLoginDTO: userLoginDTO)
        self.isLoading = true
    }
    
    
    internal func jsonAnswerStatusCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool = false) {
        self.isLoading = false
        if isNetError {
            warningLabel.text = "Ошибка сети"
            return
        }
        
        if jsonAnswerStatus == nil {
            warningLabel.text = "Ошибка на сервере"
            return
        }
        
        if jsonAnswerStatus?.status == "success" && jsonAnswerStatus?.access_token != nil {
            if self.userFacade.setJwt(context: self.context, jwt: jsonAnswerStatus!.access_token!) {
                print("jwt: \(jsonAnswerStatus!.access_token!)")
                authLoginCallback.loginSuccessfull()
            } else {
                warningLabel.text = "Ошибка сохранения токена"
            }
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "wrong"{
            warningLabel.text = "Неправильно введены логин или пароль"
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "not_auth"{
            
        } else {
            warningLabel.text = "Неизвестная ошибка на сервере"
        }
    }
}
