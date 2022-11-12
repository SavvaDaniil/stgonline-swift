//
//  PurchaseModel.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

enum PurchaseAnyType : Int {
    case PURCHASE_LESSON = 0
    case PURCHASE_SUBSCRIPTION = 1
}

struct PurchaseLessonLiteModel : Decodable {
    var id: Int
    var name: String?
    var user_id: Int = 0
    var payment_id: Int = 0
    var is_payed: Bool = false
    var date_of_payed: String?
    
    var is_expired: Bool = false
    var date_of_add: String?
    var date_of_activation: String?
    var date_of_must_be_used_to: String?
    
    var lessonMicroViewModel: LessonMicroModel?
}

struct PurchaseSubscriptionLiteModel : Decodable {
    var id: Int
    var name: String?
    var user_id: Int = 0
    var payment_id: Int = 0
    var is_payed: Bool = false
    var date_of_payed: String?
    
    var is_expired: Bool = false
    var date_of_add: String?
    var date_of_activation: String?
    var date_of_must_be_used_to: String?
    
    var subscriptionLiteViewModel: SubscriptionLiteModel?
}
