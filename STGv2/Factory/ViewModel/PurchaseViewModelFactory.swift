//
//  PurchaseViewModelFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

class PurchaseViewModelFactory {
    
    public func createPurchaseLesson(purchaseLessonLiteModel: PurchaseLessonLiteModel) -> PurchaseViewModel {
        
        var lessonMicroViewModel: LessonMicroViewModel? = nil
        if purchaseLessonLiteModel.lessonMicroViewModel != nil {
            let lessonViewModelFactory: LessonViewModelFactory = LessonViewModelFactory()
            lessonMicroViewModel = lessonViewModelFactory.createMicro(lessonMicroModel: purchaseLessonLiteModel.lessonMicroViewModel!)
        }
        
        let stringToDateConverterComponent: StringToDateConverterComponent = StringToDateConverterComponent()
        //print("purchaseLessonLiteModel.date_of_payed: \(purchaseLessonLiteModel.date_of_payed)")
        return PurchaseViewModel(
            id: purchaseLessonLiteModel.id,
            name: purchaseLessonLiteModel.name,
            user_id: purchaseLessonLiteModel.user_id,
            payment_id: purchaseLessonLiteModel.payment_id,
            is_payed: purchaseLessonLiteModel.is_payed,
            date_of_payed: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseLessonLiteModel.date_of_payed),
            is_expired: purchaseLessonLiteModel.is_expired,
            date_of_add: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseLessonLiteModel.date_of_add),
            date_of_activation: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseLessonLiteModel.date_of_activation),
            date_of_must_be_used_to: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseLessonLiteModel.date_of_must_be_used_to),
            lessonMicroViewModel: lessonMicroViewModel,
            subscriptionLiteViewModel: nil
        )
    }
    
    public func createPurchaseSubscription(purchaseSubscriptionLiteModel: PurchaseSubscriptionLiteModel) -> PurchaseViewModel {
        
        var subscriptionLiteViewModel: SubscriptionLiteViewModel? = nil
        if purchaseSubscriptionLiteModel.subscriptionLiteViewModel != nil {
            let subscriptionViewModelFactory: SubscriptionViewModelFactory = SubscriptionViewModelFactory()
            subscriptionLiteViewModel = subscriptionViewModelFactory.createLite(subscriptionLiteModel: purchaseSubscriptionLiteModel.subscriptionLiteViewModel!)
        }
        
        let stringToDateConverterComponent: StringToDateConverterComponent = StringToDateConverterComponent()
        
        return PurchaseViewModel(
            id: purchaseSubscriptionLiteModel.id,
            name: purchaseSubscriptionLiteModel.name,
            user_id: purchaseSubscriptionLiteModel.user_id,
            payment_id: purchaseSubscriptionLiteModel.payment_id,
            is_payed: purchaseSubscriptionLiteModel.is_payed,
            date_of_payed: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseSubscriptionLiteModel.date_of_payed),
            is_expired: purchaseSubscriptionLiteModel.is_expired,
            date_of_add: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseSubscriptionLiteModel.date_of_add),
            date_of_activation: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseSubscriptionLiteModel.date_of_activation),
            date_of_must_be_used_to: stringToDateConverterComponent.stringToDate(dateAsStr: purchaseSubscriptionLiteModel.date_of_must_be_used_to),
            lessonMicroViewModel: nil,
            subscriptionLiteViewModel: subscriptionLiteViewModel
        )
    }
    
}
