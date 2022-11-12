//
//  VideoSectionModel.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

struct VideoSectionLiteModel : Decodable {
    var id: Int
    var name: String?
    var videoSubsectionLiteViewModels: [VideoSubsectionLiteModel]?
}
