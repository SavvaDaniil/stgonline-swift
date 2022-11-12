//
//  AIScoreViewFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 04.11.2022.
//

import UIKit

enum AIScoreViewPosition : Int {
    case FIRST = 0
    case SECOND = 1
    case THIRD = 2
}

class AIScoreViewFactory {
    
    public func create(parentController: UIViewController, topView: UIView, parentView: UIView, aiScoreViewPosition : AIScoreViewPosition, score: Int, isActive: Bool = true) -> AIScoreView {
        
        let aiScoreBeginnersBlock = AIScoreView(score: score, isActive: isActive)
        parentView.addSubview(aiScoreBeginnersBlock)
        aiScoreBeginnersBlock.translatesAutoresizingMaskIntoConstraints = false
        aiScoreBeginnersBlock.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        //aiScoreBeginnersBlock.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: -CGFloat(parentController.view.frame.width / 3)).isActive = true
        switch aiScoreViewPosition {
            
        case .FIRST:
            aiScoreBeginnersBlock.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: -CGFloat(parentController.view.frame.width / 3)).isActive = true
        case .SECOND:
            aiScoreBeginnersBlock.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        case .THIRD:
            aiScoreBeginnersBlock.centerXAnchor.constraint(equalTo: topView.centerXAnchor, constant: CGFloat(parentController.view.frame.width / 3)).isActive = true
        }
        aiScoreBeginnersBlock.heightAnchor.constraint(equalToConstant: 40).isActive = true
        aiScoreBeginnersBlock.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        return aiScoreBeginnersBlock
    }
    
    public func createUnderBlockLabel(parentView: UIView, aiScoreView: AIScoreView, titleText: String) -> AIScoreLabel {
        
        let aiScoreLabel: AIScoreLabel = AIScoreLabel(titleText: titleText)
        parentView.addSubview(aiScoreLabel)
        aiScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        aiScoreLabel.topAnchor.constraint(equalTo: aiScoreView.bottomAnchor, constant: 8).isActive = true
        aiScoreLabel.centerXAnchor.constraint(equalTo: aiScoreView.centerXAnchor).isActive = true
        
        return aiScoreLabel
    }
    
}
