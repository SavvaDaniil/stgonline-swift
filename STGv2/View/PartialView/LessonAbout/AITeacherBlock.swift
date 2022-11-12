//
//  AITeacherBlock.swift
//  STGv2
//
//  Created by Daniil Savva on 03.11.2022.
//

import UIKit


class AITeacherBlock : UIView {
    
    private let parentController: UIViewController
    
    required init(parentController: UIViewController, pointsBeginners: Int, pointsMiddle: Int, pointsProfi: Int){
        self.parentController = parentController
        super.init(frame: CGRect())
        
        
        let aiTeacherTitle = UILabel(frame: CGRect())
        aiTeacherTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 16)
        aiTeacherTitle.textColor = .white
        aiTeacherTitle.textAlignment = .center
        aiTeacherTitle.numberOfLines = 2
        aiTeacherTitle.text = "Искусственный интеллект оценил ваше исполнение на"
        self.addSubview(aiTeacherTitle)
        aiTeacherTitle.translatesAutoresizingMaskIntoConstraints = false
        aiTeacherTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        aiTeacherTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        aiTeacherTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        aiTeacherTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let aiScoreViewFactory = AIScoreViewFactory()
        let aiScoreBeginnersBlock = aiScoreViewFactory.create(parentController: self.parentController, topView: aiTeacherTitle, parentView: self, aiScoreViewPosition:.FIRST, score: 16)
        let aiScoreBeginnersLabelBottom = aiScoreViewFactory.createUnderBlockLabel(parentView: self, aiScoreView: aiScoreBeginnersBlock, titleText: "Beginners")
        
        let aiScoreMiddleBlock = aiScoreViewFactory.create(parentController: self.parentController, topView: aiTeacherTitle, parentView: self, aiScoreViewPosition:.SECOND, score: 0, isActive: false)
        let _ = aiScoreViewFactory.createUnderBlockLabel(parentView: self, aiScoreView: aiScoreMiddleBlock, titleText: "Middle")
        
        let aiScoreProfiBlock = aiScoreViewFactory.create(parentController: self.parentController, topView: aiTeacherTitle, parentView: self, aiScoreViewPosition:.THIRD, score: 0, isActive: false)
        let _ = aiScoreViewFactory.createUnderBlockLabel(parentView: self, aiScoreView: aiScoreProfiBlock, titleText: "Profi")
        
        
        
        
        let aiPS = UILabel(frame: CGRect())
        aiPS.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        aiPS.textColor = .white
        aiPS.textAlignment = .center
        aiPS.text = "Для разбора ошибок, кликните на блоки"
        self.addSubview(aiPS)
        aiPS.translatesAutoresizingMaskIntoConstraints = false
        aiPS.topAnchor.constraint(equalTo: aiScoreBeginnersLabelBottom.bottomAnchor, constant: 20).isActive = true
        aiPS.centerXAnchor.constraint(equalTo: aiTeacherTitle.centerXAnchor).isActive = true
        
        
        
        let btnPassForAI = BtnDefault(titleText: "Оценить исполнение")
        self.addSubview(btnPassForAI)
        btnPassForAI.translatesAutoresizingMaskIntoConstraints = false
        btnPassForAI.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        btnPassForAI.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        btnPassForAI.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        btnPassForAI.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnPassForAI.addTarget(self, action: #selector(openAiRules), for: .touchUpInside)
    }
    
    @objc
    private func openAiRules(){
        let lessonAIRulesController: LessonAIRulesController = LessonAIRulesController()
        self.parentController.presentFromRight(vc: lessonAIRulesController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
