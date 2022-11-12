//
//  JsonAnswerStatus.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//

struct JsonAnswerStatus : Decodable {
    var status: String?
    var errors: String?
    var access_token: String?
    var token_type: String?
    var forget_id: Int = 0
    
    var userProfileViewModel: UserProfileModel?
    var lessonPreviewViewModels : [LessonPreviewModel]?
    var lessonLiteViewModel: LessonLiteModel?
    var lessonBuyViewModel: LessonBuyModel?
    
    var lessonVideoViewModel: LessonVideoModel?
    var purchaseLessonLiteViewModels: [PurchaseLessonLiteModel]?
    var purchaseSubscriptionLiteViewModels: [PurchaseSubscriptionLiteModel]?
}
