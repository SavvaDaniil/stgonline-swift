//
//  VideoViewModelFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

class VideoViewModelFactory {
    
    public func createLite(videoLiteModel: VideoLiteModel) -> VideoLiteViewModel {
        
        var videoSectionLiteViewModels: [VideoSectionLiteViewModel] = []
        if videoLiteModel.videoSectionLiteViewModels != nil {
            let videoSectionViewModelFactory: VideoSectionViewModelFactory = VideoSectionViewModelFactory()
            for videoSectionLiteModel in videoLiteModel.videoSectionLiteViewModels! {
                videoSectionLiteViewModels.append(
                    videoSectionViewModelFactory.createLite(videoSectionLiteModel: videoSectionLiteModel)
                )
            }
        }
        
        return VideoLiteViewModel(
            id: videoLiteModel.id,
            posterSrc: videoLiteModel.posterSrc,
            videoSrc: videoLiteModel.videoSrc,
            videoMobileSrc: videoLiteModel.videoMobileSrc,
            duration: videoLiteModel.duration,
            durationHours: videoLiteModel.durationHours,
            durationMinutes: videoLiteModel.durationMinutes,
            durationSeconds: videoLiteModel.durationSeconds,
            videoSectionLiteViewModels: videoSectionLiteViewModels
        )
    }
    
}
