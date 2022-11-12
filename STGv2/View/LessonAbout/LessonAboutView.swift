//
//  LessonAboutView.swift
//  STGv2
//
//  Created by Daniil Savva on 02.11.2022.
//

import UIKit
import AVKit
import CoreData

enum LessonAboutTabState : Int {
    case description = 0
    case aiTeacher = 1
}

class LessonAboutView : UIView {
    
    private var context: NSManagedObjectContext
    
    private var parentController: UIViewController
    private var lessonCheckAccessDelegate: LessonCheckAccessDelegate
    private var lessonLiteViewModel: LessonLiteViewModel?
    private var posterImageView: UIImageView?
    private var btnBuy: BtnDefault
    private var btnStart: BtnDefault
    private var btnTeaser: BtnDefault
    
    private var lessonAboutTabState: LessonAboutTabState = .description
    private var lessonAboutTabBtnDescription: LessonAboutTabBtn?
    private var lessonAboutTabBtnAI: LessonAboutTabBtn?
    
    private var descriptionBlock: DescriptionBlock?
    private var aiTeacherBlock: AITeacherBlock?
    
    private let userFacade: UserFacade = UserFacade()
    private let lessonFacade: LessonFacade = LessonFacade()
    private var isLoading: Bool = false
    
    required init(context: NSManagedObjectContext, parentController: UIViewController, lessonCheckAccessDelegate: LessonCheckAccessDelegate){
        self.context = context
        self.parentController = parentController
        self.lessonCheckAccessDelegate = lessonCheckAccessDelegate
        
        posterImageView = UIImageView(frame: CGRect())
        btnBuy = BtnDefault(titleText: "ПРИОБРЕСТИ")
        btnStart = BtnDefault(titleText: "НАЧАТЬ ЗАНИМАТЬСЯ")
        btnTeaser = BtnDefault(titleText: "СМОТРЕТЬ ТИЗЕР")
        super.init(frame: CGRect())
        
        self.posterImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.posterImageView!.layer.cornerRadius = 12
        self.posterImageView!.layer.borderColor = CGColor(red: 0, green: 1, blue: 244/255, alpha: 1)
        self.posterImageView!.layer.borderWidth = 2
        
        
        self.posterImageView!.layer.masksToBounds = true
        self.addSubview(self.posterImageView!)
        self.posterImageView!.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.posterImageView!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.posterImageView!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.posterImageView!.heightAnchor.constraint(equalToConstant: CGFloat(Int(self.parentController.view.frame.width) * 9 / 16 - 20)).isActive = true
        
        
        
        let iconLockImageView = UIImageView(image: UIImage(named: "icon-lock-black"))
        self.btnBuy.addSubview(iconLockImageView)
        iconLockImageView.translatesAutoresizingMaskIntoConstraints = false
        iconLockImageView.centerYAnchor.constraint(equalTo: self.btnBuy.centerYAnchor, constant: -1).isActive = true
        iconLockImageView.trailingAnchor.constraint(equalTo: self.btnBuy.centerXAnchor, constant: -54).isActive = true
        iconLockImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        iconLockImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        
        self.addSubview(self.btnBuy)
        self.btnBuy.translatesAutoresizingMaskIntoConstraints = false
        self.btnBuy.topAnchor.constraint(equalTo: self.posterImageView!.bottomAnchor, constant: 12).isActive = true
        self.btnBuy.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.btnBuy.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.btnBuy.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.btnBuy.addTarget(self, action: #selector(checkAccess), for: .touchUpInside)
        
        self.addSubview(self.btnStart)
        self.btnStart.translatesAutoresizingMaskIntoConstraints = false
        self.btnStart.topAnchor.constraint(equalTo: self.posterImageView!.bottomAnchor, constant: 12).isActive = true
        self.btnStart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.btnStart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.btnStart.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.btnStart.addTarget(self, action: #selector(checkAccess), for: .touchUpInside)
        
        
        
        self.addSubview(self.btnTeaser)
        self.btnTeaser.translatesAutoresizingMaskIntoConstraints = false
        self.btnTeaser.topAnchor.constraint(equalTo: self.btnBuy.bottomAnchor, constant: 12).isActive = true
        self.btnTeaser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.btnTeaser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.btnTeaser.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.btnTeaser.addTarget(self, action: #selector(playTeaser), for: .touchUpInside)
        
        self.lessonAboutTabBtnDescription = LessonAboutTabBtn(parentController: self.parentController, titleText: "О хореографии", lessonAboutTabState: .description, isActive: true)
        self.addSubview(self.lessonAboutTabBtnDescription!)
        self.lessonAboutTabBtnDescription!.translatesAutoresizingMaskIntoConstraints = false
        self.lessonAboutTabBtnDescription!.topAnchor.constraint(equalTo: self.btnTeaser.bottomAnchor, constant: 12).isActive = true
        self.lessonAboutTabBtnDescription!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.lessonAboutTabBtnDescription!.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -15).isActive = true
        self.lessonAboutTabBtnDescription!.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.lessonAboutTabBtnDescription!.addTarget(self, action: #selector(updateLessonAboutTabState), for: .touchUpInside)
        
        
        self.lessonAboutTabBtnAI = LessonAboutTabBtn(parentController: self.parentController, titleText: "AI преподаватель", lessonAboutTabState: .aiTeacher)
        self.addSubview(self.lessonAboutTabBtnAI!)
        self.lessonAboutTabBtnAI!.translatesAutoresizingMaskIntoConstraints = false
        self.lessonAboutTabBtnAI!.topAnchor.constraint(equalTo: self.btnTeaser.bottomAnchor, constant: 12).isActive = true
        self.lessonAboutTabBtnAI!.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 15).isActive = true
        self.lessonAboutTabBtnAI!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.lessonAboutTabBtnAI!.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.lessonAboutTabBtnAI!.addTarget(self, action: #selector(updateLessonAboutTabState), for: .touchUpInside)
        
        
        descriptionBlock = DescriptionBlock()
        self.addSubview(descriptionBlock!)
        descriptionBlock!.translatesAutoresizingMaskIntoConstraints = false
        descriptionBlock!.topAnchor.constraint(equalTo: self.lessonAboutTabBtnDescription!.bottomAnchor, constant: 20).isActive = true
        descriptionBlock!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        descriptionBlock!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        descriptionBlock!.heightAnchor.constraint(equalToConstant: 120).isActive = true
        //self.descriptionBlock?.isHidden = true
        
        
        
        self.aiTeacherBlock = AITeacherBlock(parentController: self.parentController, pointsBeginners: 16, pointsMiddle: 0, pointsProfi: 0)
        self.addSubview(self.aiTeacherBlock!)
        self.aiTeacherBlock!.translatesAutoresizingMaskIntoConstraints = false
        self.aiTeacherBlock!.topAnchor.constraint(equalTo: self.lessonAboutTabBtnDescription!.bottomAnchor, constant: 20).isActive = true
        self.aiTeacherBlock!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.aiTeacherBlock!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.aiTeacherBlock!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        self.aiTeacherBlock!.isHidden = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(lessonLiteViewModel: LessonLiteViewModel){
        self.lessonLiteViewModel = lessonLiteViewModel
        
        if GlobalVariables.lessonImagesDataCash[self.lessonLiteViewModel?.id ?? 0] != nil {
            self.posterImageView!.image = GlobalVariables.lessonImagesDataCash[self.lessonLiteViewModel?.id ?? 0]
        } else {
            self.posterImageView!.image = GlobalVariables.defaultPreview
        }
        
        self.btnBuy.isHidden = lessonLiteViewModel.active
        self.btnStart.isHidden = !lessonLiteViewModel.active
        
        if lessonLiteViewModel.teaser_src != nil {
            self.btnTeaser.isHidden = false
        } else {
            self.btnTeaser.isHidden = true
        }
        
        self.descriptionBlock?.setName(name: lessonLiteViewModel.name ?? "")
        self.descriptionBlock?.setMusicName(musicName: lessonLiteViewModel.music_name ?? "")
        self.descriptionBlock?.setStyleName(styleName: lessonLiteViewModel.style_name ?? "")
        self.descriptionBlock?.setTeacherName(name: lessonLiteViewModel.teacher_name ?? "")
        //self.descriptionBlock?.setIsActive(value: lessonLiteViewModel.active)
        //descriptionBlock!.heightAnchor.constraint(equalToConstant: (lessonLiteViewModel.active ? 50 : 80)).isActive = true
        self.descriptionBlock?.setPrice(price: lessonLiteViewModel.price_str ?? "")
        
        self.lessonAboutTabBtnAI?.isHidden = !lessonLiteViewModel.is_ai_available
    }
    
    @objc
    private func updateLessonAboutTabState(_ sender: LessonAboutTabBtn){
        self.lessonAboutTabState =  sender.getLessonAboutTabState()
        switch sender.getLessonAboutTabState() {
            
        case .description:
            self.lessonAboutTabBtnDescription!.setIsActive(isActive: true)
            self.lessonAboutTabBtnAI!.setIsActive(isActive: false)
            self.descriptionBlock!.isHidden = false
            self.aiTeacherBlock!.isHidden = true
            break
        case .aiTeacher:
            self.lessonAboutTabBtnDescription!.setIsActive(isActive: false)
            self.descriptionBlock!.isHidden = true
            self.aiTeacherBlock!.isHidden = false
            self.lessonAboutTabBtnAI!.setIsActive(isActive: true)
            break
        }
    }
    
    @objc
    private func checkAccess(){
        //self.setStateLoading()
        /*
        if self.isLoading {
            return
        }
        self.isLoading = true
        let jwt: String? = self.userFacade.getJwt(context: self.context)
        self.lessonFacade.checkAccess(lessonCheckAccessFetchCallbackDelegate: self, lessonId: self.lessonLiteViewModel!.id, jwt: jwt)
        */
        self.lessonCheckAccessDelegate.lessonCheckAccess()
    }
    
    @objc
    private func playTeaser(){
        if self.lessonLiteViewModel?.teaser_src == nil {
            return
        }
        let url: URL = URL(string: self.lessonLiteViewModel?.teaser_src ?? "")!
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.parentController.present(vc, animated: true) { vc.player?.play() }
    }
    
    
}
