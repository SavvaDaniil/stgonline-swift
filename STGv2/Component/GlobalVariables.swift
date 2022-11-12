//
//  GlobalVariables.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit

struct GlobalVariables {
    
    static let startingYPos: CGFloat = {
        var heightToReturn: CGFloat = 0.0
        for window in UIApplication.shared.windows {
            if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                heightToReturn = height
            }
        }
        return heightToReturn
    }()
    
    static let baseDomain: String = "XXXXXXXXXXXXXX"
    static let titleHeight: CGFloat = 44

    
    ...
    
    
}
