//
//  VideoViewModel.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//


struct VideoLiteViewModel {
    var id: Int
    var posterSrc: String?
    var videoSrc: String?
    var videoMobileSrc: String?
    var duration: Int = 0

    var durationHours: Int = 0
    var durationMinutes: Int = 0
    var durationSeconds: Int = 0

    var videoSectionLiteViewModels: [VideoSectionLiteViewModel]?
}
