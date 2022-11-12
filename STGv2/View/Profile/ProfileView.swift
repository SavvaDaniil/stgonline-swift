//
//  ProfileView.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import CoreData
import UIKit

class ProfileView : UIView, InputFormGroupDelegate, JsonAnswerStatusCallbackDelegate {
    
    private var context: NSManagedObjectContext
    
    internal var username: String?
    private let warningLabel: UILabel = UILabel()
    private let btnSave = BtnDefault(titleText: "Сохранить")
    
    var usernameInputFormGroup : InputFormGroup?
    var passwordNewInputFormGroup : InputFormGroup?
    var passwordNewAgainInputFormGroup : InputFormGroup?
    var passwordCurrentInputFormGroup : InputFormGroup?
    
    private let userFacade: UserFacade = UserFacade()
    private var isLoading: Bool = false
    
    required init(
        context: NSManagedObjectContext,
        parentController: UIViewController
    ){
        self.context = context
        super.init(frame: CGRect())
        
        
        let inputFormGroupFactory = InputFormGroupFactory()
        self.usernameInputFormGroup = inputFormGroupFactory.create(parentController: parentController, parentView: self, topView: nil, inputFormGroupDelegate: self, profileFieldType: .username, titleLable: "Электронная почта", keyboardType: .emailAddress)
        
        self.passwordNewInputFormGroup = inputFormGroupFactory.create(parentController: parentController, parentView: self, topView: usernameInputFormGroup, inputFormGroupDelegate: self,  profileFieldType: .passwordNew, titleLable: "Новый пароль", keyboardType: .default)
        
        self.passwordNewAgainInputFormGroup = inputFormGroupFactory.create(parentController: parentController, parentView: self, topView: passwordNewInputFormGroup, inputFormGroupDelegate: self,  profileFieldType: .passwordNewAgain, titleLable: "Новый пароль еще раз", keyboardType: .default)
        
        self.passwordCurrentInputFormGroup = inputFormGroupFactory.create(parentController: parentController, parentView: self, topView: passwordNewAgainInputFormGroup, inputFormGroupDelegate: self,  profileFieldType: .passwordCurrent, titleLable: "Текущий пароль", keyboardType: .default)
        
        
        self.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSave.addTarget(self, action: #selector(profileUpdate), for: .touchUpInside)
        
        
        warningLabel.text = ""
        warningLabel.textColor = GlobalVariables.activeColor
        warningLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        warningLabel.textAlignment = .center
        self.addSubview(warningLabel)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.bottomAnchor.constraint(equalTo: btnSave.topAnchor, constant: -20).isActive = true
        warningLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        warningLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func clearWarning(){
        warningLabel.text = ""
    }
    
    @objc
    private func profileUpdate(){
        if self.isLoading {
            return
        }
        self.clearWarning()
        let username: String = self.usernameInputFormGroup!.getInputValue() ?? ""
        let passwordNew: String = self.passwordNewInputFormGroup!.getInputValue() ?? ""
        let passwordAgain: String = self.passwordNewAgainInputFormGroup!.getInputValue() ?? ""
        let passwordCurrent: String = self.passwordCurrentInputFormGroup!.getInputValue() ?? ""
        if username == "" {
            warningLabel.text = "Логин обязателен для заполнения"
            return
        } else if passwordNew != "" && passwordNew != passwordAgain {
            warningLabel.text = "Пароли не совпадают"
            return
        } else if passwordNew != "" && passwordCurrent == "" {
            warningLabel.text = "Текущий пароль не установлен"
            return
        }
        
        let userProfileEditDTO: UserProfileEditDTO = UserProfileEditDTO(username: username, passwordNew: passwordNew, passwordCurrent: passwordCurrent)
        let jwt: String? = self.userFacade.getJwt(context: self.context)
        if jwt == nil {
            
            return
        }
        self.userFacade.profileUpdate(
            jsonAnswerStatusCallbackDelegate: self,
            jwt: jwt!,
            userProfileEditDTO: userProfileEditDTO
        )
        
        self.isLoading = true
    }
    
    public func profileFillData(username: String){
        self.usernameInputFormGroup?.setInputValue(value: username)
    }
    
    internal func updateFieldValue(profileFieldType: ProfileFieldType, value: String?) {
        self.clearWarning()
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
        
        if jsonAnswerStatus?.status == "success" {
            warningLabel.text = "Успешно сохранено"
            if jsonAnswerStatus!.access_token != nil {
                if !self.userFacade.setJwt(context: self.context, jwt: jsonAnswerStatus!.access_token!) {
                    warningLabel.text = "Ошибка сохранения токена"
                }
            }
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "wrong"{
            warningLabel.text = "Неправильно введены логин или пароль"
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "username_already_exist"{
            warningLabel.text = "Логин уже зарегистрирован в базе"
        } else if jsonAnswerStatus?.status == "error" && jsonAnswerStatus?.errors == "current_password_wrong"{
            warningLabel.text = "Текущий пароль введен неверно"
        } else {
            warningLabel.text = "Неизвестная ошибка на сервере"
        }
    }
    
}


/*
let inputFormGroup = UIView(frame: CGRect())
self.addSubview(inputFormGroup)
inputFormGroup.translatesAutoresizingMaskIntoConstraints = false
inputFormGroup.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
inputFormGroup.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
inputFormGroup.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
inputFormGroup.heightAnchor.constraint(equalToConstant: 50).isActive = true


let usernameLabel = UILabel()
usernameLabel.text = "Электронная почта"
usernameLabel.textColor = .white
usernameLabel.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
usernameLabel.textAlignment = .left

inputFormGroup.addSubview(usernameLabel)
usernameLabel.translatesAutoresizingMaskIntoConstraints = false
usernameLabel.topAnchor.constraint(equalTo: inputFormGroup.topAnchor).isActive = true
usernameLabel.leadingAnchor.constraint(equalTo: inputFormGroup.leadingAnchor, constant: 20).isActive = true
usernameLabel.trailingAnchor.constraint(equalTo: inputFormGroup.trailingAnchor, constant: 20).isActive = true
usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true



let usernameField = UITextFieldDefault("", .emailAddress)
inputFormGroup.addSubview(usernameField)
usernameField.translatesAutoresizingMaskIntoConstraints = false
usernameField.bottomAnchor.constraint(equalTo: inputFormGroup.bottomAnchor).isActive = true
usernameField.leadingAnchor.constraint(equalTo: inputFormGroup.leadingAnchor, constant: 20).isActive = true
usernameField.trailingAnchor.constraint(equalTo: inputFormGroup.trailingAnchor, constant: 20).isActive = true
usernameField.heightAnchor.constraint(equalToConstant: 20).isActive = true
usernameField.delegate = parentController
*/
