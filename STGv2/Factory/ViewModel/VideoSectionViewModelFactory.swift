//
//  VideoSectionViewModelFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

class VideoSectionViewModelFactory {
    
    public func createLite(videoSectionLiteModel: VideoSectionLiteModel) -> VideoSectionLiteViewModel {
        
        var videoSubsectionLiteViewModels: [VideoSubsectionLiteViewModel] = []
        if videoSectionLiteModel.videoSubsectionLiteViewModels != nil {
            let videoSubsectionViewModelFactory: VideoSubsectionViewModelFactory = VideoSubsectionViewModelFactory()
            for videoSubsectionLiteModel in videoSectionLiteModel.videoSubsectionLiteViewModels! {
                videoSubsectionLiteViewModels.append(
                    videoSubsectionViewModelFactory.createLite(videoSubsectionLiteModel: videoSubsectionLiteModel)
                )
            }
        }
        
        return VideoSectionLiteViewModel(
            id: videoSectionLiteModel.id,
            name: videoSectionLiteModel.name,
            videoSubsectionLiteViewModels: videoSubsectionLiteViewModels
        )
    }
}
