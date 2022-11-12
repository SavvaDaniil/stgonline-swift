//
//  RegistrationView.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//

import CoreData
import UIKit


class RegistrationView : UIView, JsonAnswerStatusCallbackDelegate {
    
    private var context: NSManagedObjectContext
    private var changeAuthStateDelegate: ChangeAuthStateDelegate
    private var authLoginCallback: AuthLoginCallback
    
    private let usernameLabel: UILabel = UILabel()
    private let usernameField: UITextFieldDefault = UITextFieldDefault("", .emailAddress)
    
    private let passwordLabel: UILabel = UILabel()
    private let passwordField: UITextFieldDefault = UITextFieldDefault("", .default, true)
    
    private let passwordAgainLabel: UILabel = UILabel()
    private let passwordAgainField: UITextFieldDefault = UITextFieldDefault("", .default, true)
    
    private let warningLabel: UILabel = UILabel()
    
    private let btnRegistration = BtnDefault(titleText: "Регистрация")
    
    private let labelToLogin = UILabel()
    private let labelToForget = UILabel()
    private let btnToLogin = BtnDefault(titleText: "Войти", fontSize: 12)
    private let btnToForget = BtnDefault(titleText: "Восстановить", fontSize: 12)
    
    private let userFacade: UserFacade = UserFacade()
    private var isLoading: Bool = false
    
    required init(context: NSManagedObjectContext, changeAuthStateDelegate: ChangeAuthStateDelegate, authLoginCallback: AuthLoginCallback){
        self.context = context
        self.changeAuthStateDelegate = changeAuthStateDelegate
        self.authLoginCallback = authLoginCallback
        super.init(frame: CGRect())
        
        
        self.addSubview(passwordAgainField)
        passwordAgainField.translatesAutoresizingMaskIntoConstraints = false
        passwordAgainField.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        passwordAgainField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        passwordAgainField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        passwordAgainField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //usernameField.addTarget(self, action: #selector(updateFieldValue), for: .editingChanged)
        passwordAgainField.delegate = self
        passwordAgainField.addTarget(self, action: #selector(clearWarning), for: .editingChanged)
        
        
        passwordAgainLabel.text = "Пароль еще раз"
        passwordAgainLabel.textColor = .white
        passwordAgainLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        passwordAgainLabel.textAlignment = .left
        self.addSubview(passwordAgainLabel)
        passwordAgainLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordAgainLabel.bottomAnchor.constraint(equalTo: passwordAgainField.topAnchor, constant: -10).isActive = true
        passwordAgainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        passwordAgainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        passwordAgainLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.bottomAnchor.constraint(equalTo: passwordAgainLabel.topAnchor, constant: -20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //usernameField.addTarget(self, action: #selector(updateFieldValue), for: .editingChanged)
        passwordField.delegate = self
        passwordField.addTarget(self, action: #selector(clearWarning), for: .editingChanged)
        
        
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
        //usernameField.addTarget(self, action: #selector(updateFieldValue), for: .editingChanged)
        usernameField.delegate = self
        usernameField.addTarget(self, action: #selector(clearWarning), for: .editingChanged)
        
        
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
        warningLabel.topAnchor.constraint(equalTo: passwordAgainField.bottomAnchor, constant: 24).isActive = true
        warningLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        warningLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.addSubview(btnRegistration)
        btnRegistration.translatesAutoresizingMaskIntoConstraints = false
        btnRegistration.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 20).isActive = true
        btnRegistration.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        btnRegistration.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnRegistration.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        labelToLogin.text = "У меня есть аккаунт"
        labelToLogin.textColor = GlobalVariables.grayColor
        labelToLogin.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        labelToLogin.textAlignment = .right
        self.addSubview(labelToLogin)
        labelToLogin.translatesAutoresizingMaskIntoConstraints = false
        labelToLogin.topAnchor.constraint(equalTo: btnRegistration.bottomAnchor, constant: 60).isActive = true
        labelToLogin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        labelToLogin.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        labelToLogin.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(btnToLogin)
        btnToLogin.translatesAutoresizingMaskIntoConstraints = false
        btnToLogin.topAnchor.constraint(equalTo: btnRegistration.bottomAnchor, constant: 55).isActive = true
        btnToLogin.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        btnToLogin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnToLogin.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnToLogin.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        
        
        
        
        labelToForget.text = "Забыли пароль"
        labelToForget.textColor = GlobalVariables.grayColor
        labelToForget.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        labelToForget.textAlignment = .right
        self.addSubview(labelToForget)
        labelToForget.translatesAutoresizingMaskIntoConstraints = false
        labelToForget.topAnchor.constraint(equalTo: labelToLogin.bottomAnchor, constant: 30).isActive = true
        labelToForget.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        labelToForget.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        labelToForget.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(btnToForget)
        btnToForget.translatesAutoresizingMaskIntoConstraints = false
        btnToForget.topAnchor.constraint(equalTo: btnToLogin.bottomAnchor, constant: 20).isActive = true
        btnToForget.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        btnToForget.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnToForget.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnToForget.addTarget(self, action: #selector(toForget), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func toLogin(){
        self.changeAuthStateDelegate.change(authenticationViewState: .LOGIN)
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
    private func registration(){
        if self.isLoading {
            return
        }
        self.clearWarning()
        let username: String = usernameField.text ?? ""
        let password: String = passwordField.text ?? ""
        let passwordAgain: String = passwordField.text ?? ""
        if username == "" || password == "" || passwordAgain == "" {
            warningLabel.text = "Оба поля обязательны для заполнения"
            return
        } else if password != passwordAgain {
            warningLabel.text = "Пароли не совпадают"
            return
        }
        
        let userRegistrationDTO: UserRegistrationDTO = UserRegistrationDTO(username: username, password: password)
        self.userFacade.registration(jsonAnswerStatusCallbackDelegate: self, userRegistrationDTO: userRegistrationDTO)
        self.isLoading = true
    }
    
    
    internal func jsonAnswerStatusCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool) {
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
                self.authLoginCallback.loginSuccessfull()
            } else {
                warningLabel.text = "Ошибка сохранения токена"
            }
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "username_already_exist"{
            warningLabel.text = "Логин уже зарегистрирован в базе"
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "not_auth"{
            
        } else {
            warningLabel.text = "Неизвестная ошибка на сервере"
        }
    }
}
