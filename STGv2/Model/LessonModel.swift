//
//  LessonModel.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

import UIKit



struct LessonVideoModel : Decodable {
    var id: Int
    var videoLiteViewModel: VideoLiteModel?
}

struct LessonMicroModel : Decodable {
    var id: Int
    var name: String?
    var days: Int = 0
    var price: Int = 0
}

struct LessonLiteModel : Decodable {
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

struct LessonBuyModel : Decodable {
    var id: Int
    var lessonLiteViewModel: LessonLiteModel?
    var subscriptionLiteViewModels : [SubscriptionLiteModel]?
}

struct LessonPreviewModel : Decodable {
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

class LessonPreviewDataCash {
    
    public var id: Int
    public var name: String?
    public var shortName: String?
    public var active: Bool
    public var isAIAvailable: Bool
    
    public var levelName: String?
    public var lessonTypeName: String?
    public var styleName: String?
    public var teacherName: String?
    
    public var posterSrc: String?
    public var posterImage: UIImage?
    
    init(
        id: Int,
        name: String,
        shortName: String,
        active: Bool,
        isAIAvailable: Bool,
        levelName: String?,
        lessonTypeName: String?,
        styleName: String?,
        teacherName: String?,
        posterSrc: String?,
        posterImage: UIImage? = nil
    ){
        self.id = id
        self.name = name
        self.shortName = shortName
        self.active = active
        self.isAIAvailable = isAIAvailable
        self.levelName = levelName
        self.lessonTypeName = lessonTypeName
        self.styleName = styleName
        self.teacherName = teacherName
        self.posterSrc = posterSrc
        self.posterImage = posterImage
    }
}
