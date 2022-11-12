//
//  LessonViewModelFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

class LessonViewModelFactory {
    
    public func createVideo(lessonVideoModel: LessonVideoModel) -> LessonVideoViewModel {
        
        var videoLiteViewModel: VideoLiteViewModel? = nil
        if lessonVideoModel.videoLiteViewModel != nil {
            let videoViewModelFactory: VideoViewModelFactory = VideoViewModelFactory()
            videoLiteViewModel = videoViewModelFactory.createLite(videoLiteModel: lessonVideoModel.videoLiteViewModel!)
        }
        
        return LessonVideoViewModel(
            id: lessonVideoModel.id,
            videoLiteViewModel: videoLiteViewModel
        )
    }
    
    public func createPreviewsList(lessonPreviewModels: [LessonPreviewModel]) -> [LessonPreviewViewModel] {
        var lessonPreviewViewModels: [LessonPreviewViewModel] = []
        for lessonPreviewModel in lessonPreviewModels {
            lessonPreviewViewModels.append(self.createPreview(lessonPreviewModel: lessonPreviewModel))
        }
        return lessonPreviewViewModels
    }
    
    public func createPreview(lessonPreviewModel: LessonPreviewModel) -> LessonPreviewViewModel {
        return LessonPreviewViewModel(
            id: lessonPreviewModel.id,
            name: lessonPreviewModel.name,
            short_name: lessonPreviewModel.short_name,
            active: lessonPreviewModel.active,
            is_ai_available: lessonPreviewModel.is_ai_available,
            level_name: lessonPreviewModel.level_name,
            lesson_type_name: lessonPreviewModel.lesson_type_name,
            style_name: lessonPreviewModel.style_name,
            teacher_name: lessonPreviewModel.teacher_name,
            poster_src: lessonPreviewModel.poster_src
        )
    }
    
    public func createBuy(lessonBuyModel: LessonBuyModel) -> LessonBuyViewModel {
        
        var lessonLiteViewModel: LessonLiteViewModel? = nil
        if lessonBuyModel.lessonLiteViewModel != nil {
            lessonLiteViewModel = self.createLite(lessonLiteModel: lessonBuyModel.lessonLiteViewModel!)
        }
        var subscriptionLiteViewModels : [SubscriptionLiteViewModel] = []
        if lessonBuyModel.subscriptionLiteViewModels != nil {
            let subscriptionViewModelFactory = SubscriptionViewModelFactory()
            for subscriptionLiteModel in lessonBuyModel.subscriptionLiteViewModels! {
                subscriptionLiteViewModels.append(
                    subscriptionViewModelFactory.createLite(subscriptionLiteModel: subscriptionLiteModel)
                )
            }
        }
        
        return LessonBuyViewModel(
            id:lessonBuyModel.id,
            lessonLiteViewModel: lessonLiteViewModel,
            subscriptionLiteViewModels: subscriptionLiteViewModels
        )
    }
    
    public func createMicro(lessonMicroModel: LessonMicroModel) -> LessonMicroViewModel {
        return LessonMicroViewModel(
            id: lessonMicroModel.id,
            name: lessonMicroModel.name,
            days: lessonMicroModel.days,
            price: lessonMicroModel.price
        )
    }
    
    public func createLite(lessonLiteModel: LessonLiteModel) -> LessonLiteViewModel {
        return LessonLiteViewModel(
            id: lessonLiteModel.id,
            name: lessonLiteModel.name,
            short_name: lessonLiteModel.short_name,
            music_name: lessonLiteModel.music_name,
            price: lessonLiteModel.price,
            price_str: lessonLiteModel.price_str,
            active: lessonLiteModel.active,
            is_ai_available: lessonLiteModel.is_ai_available,
            
            level_name: lessonLiteModel.level_name,
            lesson_type_name: lessonLiteModel.lesson_type_name,
            style_name: lessonLiteModel.style_name,
            teacher_name: lessonLiteModel.teacher_name,
            
            poster_src: lessonLiteModel.poster_src,
            teaser_src: lessonLiteModel.teaser_src
        )
    }
    
    
}
