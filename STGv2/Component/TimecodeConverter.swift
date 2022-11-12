//
//  TimecodeConverter.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

import Foundation

class TimecodeConverter {
    public static func toString(_ progressTime: Float?) -> String{
        
        if progressTime == nil {
            return "00:00:00"
        }
        
        let secondsInt = Int(progressTime!)
        let seconds: String = (((secondsInt % 3600) % 60) < 10 ? "0" + String(((secondsInt % 3600) % 60)) : String(((secondsInt % 3600) % 60)))
        let hours = (Int(secondsInt / 3600) < 10 ? "0" + String(Int(secondsInt / 3600)) : String(Int(secondsInt / 3600)))
        let minutes = (Int((secondsInt % 3600) / 60) < 10 ? "0" + String(Int((secondsInt % 3600) / 60)) : String(Int((secondsInt % 3600) / 60)))
        return String("\(hours):\(minutes):\(seconds)")
    }
    
    public static func getSecondsFromVideoSubsection(videoSubsectionLiteViewModel: VideoSubsectionLiteViewModel) -> Float64 {
        return Float64((videoSubsectionLiteViewModel.timing_minutes) * 60 + (videoSubsectionLiteViewModel.timing_seconds))
    }
}
