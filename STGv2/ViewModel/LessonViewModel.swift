//
//  LessonViewModel.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

struct LessonVideoViewModel {
    var id: Int
    var videoLiteViewModel: VideoLiteViewModel?
}

struct LessonMicroViewModel : Decodable {
    var id: Int
    var name: String?
    var days: Int = 0
    var price: Int = 0
}

struct LessonLiteViewModel {
    var id: Int
    var name: String?
    var short_name: String?
    var music_name: String?
    var price: Int = 0
    var price_str: String?
    var active: Bool
    var is_ai_available: Bool
    
    var level_name: String?
    var lesson_type_name: String?
    var style_name: String?
    var teacher_name: String?
    
    var poster_src: String?
    var teaser_src: String?
}

struct LessonBuyViewModel {
    var id: Int
    var lessonLiteViewModel: LessonLiteViewModel?
    var subscriptionLiteViewModels : [SubscriptionLiteViewModel]?
}

struct LessonPreviewViewModel {
    var id: Int
    var name: String?
    var short_name: String?
    var active: Bool
    var is_ai_available: Bool
    
    var level_name: String?
    var lesson_type_name: String?
    var style_name: String?
    var teacher_name: String?
    
    var poster_src: String?
}
