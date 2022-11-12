//
//  UserFacade.swift
//  STGv2
//
//  Created by Daniil Savva on 27.10.2022.
//

import CoreData

class UserFacade : PurchaseLitesFetchCallbackDelegate {
    
    private let userService: UserService = UserService()
    private var purchaseLitesCallbackDelegate: PurchaseLitesCallbackDelegate?
    
    public func isAuth(context: NSManagedObjectContext) -> Bool {
        let techDataRepository: TechDataRepository = TechDataRepository(context: context)
        return techDataRepository.isAccessTokenExist()
    }
    
    
    public func login(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate, userLoginDTO: UserLoginDTO
    ){
        userService.login(
            jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate,
            username: userLoginDTO.username,
            password: userLoginDTO.password
        )
    }
    
    public func registration(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate, userRegistrationDTO: UserRegistrationDTO
    ){
        userService.registration(
            jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate,
            username: userRegistrationDTO.username,
            password: userRegistrationDTO.password
        )
    }
    
    public func forget(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate, userForgetDTO: UserForgetDTO
    ){
        userService.forget(
            jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate,
            step: userForgetDTO.step,
            username: userForgetDTO.username,
            forget_id: userForgetDTO.forget_id,
            code: userForgetDTO.code
        )
    }
    
    public func profileGet(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate, jwt: String
    ){
        userService.profileGet(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, jwt: jwt)
    }
    
    public func profileUpdate(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate,
        jwt: String,
        userProfileEditDTO: UserProfileEditDTO
    ){
        userService.profileUpdate(
            jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate,
            jwt: jwt,
            username: userProfileEditDTO.username,
            passwordNew: userProfileEditDTO.passwordNew,
            passwordCurrent: userProfileEditDTO.passwordCurrent
        )
    }
    
    public func setJwt(context: NSManagedObjectContext, jwt: String) -> Bool {
        let techDataRepository: TechDataRepository = TechDataRepository(context: context)
        return techDataRepository.updateAccessToken(value: jwt)
    }
    
    public func getJwt(context: NSManagedObjectContext) -> String? {
        let techDataRepository: TechDataRepository = TechDataRepository(context: context)
        return techDataRepository.getAccessToken()
    }
    
    public func logout(context: NSManagedObjectContext) -> Bool {
        let techDataRepository: TechDataRepository = TechDataRepository(context: context)
        return techDataRepository.updateAccessToken(value: nil)
    }
    
    
    public func listAllPurchaseLites(
        purchaseLitesCallbackDelegate: PurchaseLitesCallbackDelegate, jwt: String
    ){
        self.purchaseLitesCallbackDelegate = purchaseLitesCallbackDelegate
        userService.listAllPurchaseLites(purchaseLitesFetchCallbackDelegate: self, jwt: jwt)
    }
    
    internal func purchaseLitesFetchCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool) {
        if jsonAnswerStatus == nil || isNetError {
            print("purchaseLitesFetchCallback Ошибка сети")
            //GlobalVariables.isPurchasePreviewsFetching = false
            self.purchaseLitesCallbackDelegate!.purchaseLitesCallback(isNetError: true)
            return
        }
        
        if jsonAnswerStatus?.status == "success" {
            //let lessonViewModelFactory: LessonViewModelFactory = LessonViewModelFactory()
            //let lessonPreviewViewModels: [LessonPreviewViewModel] = lessonViewModelFactory.createPreviewsList(lessonPreviewModels: (jsonAnswerStatus?.lessonPreviewViewModels)!)
            
            var purchaseViewModels: [PurchaseViewModel] = []
            let purchaseViewModelFactory: PurchaseViewModelFactory = PurchaseViewModelFactory()
            
            if jsonAnswerStatus!.purchaseLessonLiteViewModels != nil {
                for purchaseLessonLiteModel in jsonAnswerStatus!.purchaseLessonLiteViewModels! {
                    purchaseViewModels.append(
                        purchaseViewModelFactory.createPurchaseLesson(purchaseLessonLiteModel: purchaseLessonLiteModel)
                    )
                }
            }
            if jsonAnswerStatus!.purchaseSubscriptionLiteViewModels != nil {
                for purchaseSubscriptionLiteViewModel in jsonAnswerStatus!.purchaseSubscriptionLiteViewModels! {
                    purchaseViewModels.append(
                        purchaseViewModelFactory.createPurchaseSubscription(purchaseSubscriptionLiteModel: purchaseSubscriptionLiteViewModel)
                    )
                }
            }
            
            purchaseViewModels = purchaseViewModels.sorted(by: {
                $0.date_of_add ?? Date() > $1.date_of_add ?? Date()
            })
            
            GlobalVariables.purchaseViewModels = purchaseViewModels
            self.purchaseLitesCallbackDelegate?.purchaseLitesCallback(isNetError: false)
        } else {
            print("lessonSearchCallback Ошибка сети")
            //GlobalVariables.isPurchasePreviewsFetching = false
            self.purchaseLitesCallbackDelegate!.purchaseLitesCallback(isNetError: true)
            return
        }
    }
    
    
    
}
