//
//  VideoSubsectionViewModelFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

class VideoSubsectionViewModelFactory {
    
    public func createLite(videoSubsectionLiteModel : VideoSubsectionLiteModel) -> VideoSubsectionLiteViewModel {
        return VideoSubsectionLiteViewModel(
            id: videoSubsectionLiteModel.id,
            name: videoSubsectionLiteModel.name,
            timing_minutes: videoSubsectionLiteModel.timing_minutes,
            timing_seconds: videoSubsectionLiteModel.timing_seconds
        )
    }
}
