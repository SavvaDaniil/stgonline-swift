//
//  StringToDateConverterComponent.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

import Foundation

class StringToDateConverterComponent {
    
    public func stringToDate(dateAsStr: String?) -> Date? {
        if dateAsStr == nil {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
        let date = dateFormatter.date(from: dateAsStr!)
        return date
    }
    
}
