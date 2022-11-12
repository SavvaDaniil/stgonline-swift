//
//  PurchaseViewModel.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

import Foundation

class PurchaseViewModel {
    var id: Int
    var name: String?
    var user_id: Int = 0
    var payment_id: Int = 0
    var is_payed: Bool = false
    var date_of_payed: Date?
    
    var is_expired: Bool = false
    var date_of_add: Date?
    var date_of_activation: Date?
    var date_of_must_be_used_to: Date?
    var lessonMicroViewModel: LessonMicroViewModel?
    var subscriptionLiteViewModel: SubscriptionLiteViewModel?
    
    init(
        id: Int,
        name: String?,
        user_id: Int = 0,
        payment_id: Int = 0,
        is_payed: Bool = false,
        date_of_payed: Date?,
        
        is_expired: Bool = false,
        date_of_add: Date?,
        date_of_activation: Date?,
        date_of_must_be_used_to: Date?,
        lessonMicroViewModel: LessonMicroViewModel?,
        subscriptionLiteViewModel: SubscriptionLiteViewModel?
    ){
        self.id = id
        self.name = name
        self.user_id = user_id
        self.payment_id = payment_id
        self.is_payed = is_payed
        self.date_of_payed = date_of_payed
        self.is_expired = is_expired
        self.date_of_add = date_of_add
        self.date_of_activation = date_of_activation
        self.date_of_must_be_used_to = date_of_must_be_used_to
        self.lessonMicroViewModel = lessonMicroViewModel
        self.subscriptionLiteViewModel = subscriptionLiteViewModel
    }
}

/*
class PurchaseLessonLiteViewModel : PurchaseAbstractViewModel {
    
    var lessonMicroViewModel: LessonMicroViewModel?
    
    init(
        id: Int,
        name: String?,
        user_id: Int = 0,
        payment_id: Int = 0,
        is_payed: Bool = false,
        date_of_payed: Date?,
        
        is_expired: Bool = false,
        date_of_add: Date?,
        date_of_activation: Date?,
        date_of_must_be_used_to: Date?,
        lessonMicroViewModel: LessonMicroViewModel?
    ){
        super.init(
            id: id,
            name: name,
            user_id: user_id,
            payment_id: payment_id,
            is_payed: is_payed,
            date_of_payed: date_of_payed,
            
            is_expired: is_expired,
            date_of_add: date_of_add,
            date_of_activation: date_of_activation,
            date_of_must_be_used_to: date_of_must_be_used_to
        )
        self.lessonMicroViewModel = lessonMicroViewModel
    }
}

class PurchaseSubscriptionLiteViewModel : PurchaseAbstractViewModel {
    
    
    var subscriptionLiteViewModel: SubscriptionLiteViewModel?
    init(
        id: Int,
        name: String?,
        user_id: Int = 0,
        payment_id: Int = 0,
        is_payed: Bool = false,
        date_of_payed: Date?,
        
        is_expired: Bool = false,
        date_of_add: Date?,
        date_of_activation: Date?,
        date_of_must_be_used_to: Date?,
        subscriptionLiteViewModel: SubscriptionLiteViewModel?
    ){
        super.init(
            id: id,
            name: name,
            user_id: user_id,
            payment_id: payment_id,
            is_payed: is_payed,
            date_of_payed: date_of_payed,
            
            is_expired: is_expired,
            date_of_add: date_of_add,
            date_of_activation: date_of_activation,
            date_of_must_be_used_to: date_of_must_be_used_to
        )
        self.subscriptionLiteViewModel = subscriptionLiteViewModel
    }
}
*/
