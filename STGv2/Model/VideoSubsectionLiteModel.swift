//
//  VideoSubsectionLiteModel.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

struct VideoSubsectionLiteModel : Decodable {
    var id: Int
    var name: String?
    var timing_minutes: Int = 0
    var timing_seconds: Int = 0
}
