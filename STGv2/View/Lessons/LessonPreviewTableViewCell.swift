//
//  LessonPreviewTableViewCell.swift
//  STGv2
//
//  Created by Daniil Savva on 01.11.2022.
//

import UIKit

class LessonPreviewTableViewCell : UITableViewCell {
    
    private var lessonPreviewDataCash: LessonPreviewDataCash?
    
    private let steYBetweenDescription = 2
    
    required init(
        lessonPreviewDataCash: LessonPreviewDataCash?,
        parentView: UIView
    ){
        self.lessonPreviewDataCash = lessonPreviewDataCash
        
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellLessonPreview")
        contentView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        //view.backgroundColor = .red
        
        
        let bgdImg = GlobalVariables.defaultPreview
        let bgdImgView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: (Int(parentView.frame.width) - 20),
                height: (Int(parentView.frame.width) * 9 / 16 - 20)
            )
        )
        bgdImgView.image = bgdImg
        
        if GlobalVariables.lessonImagesDataCash[lessonPreviewDataCash!.id] != nil {
            bgdImgView.image = GlobalVariables.lessonImagesDataCash[lessonPreviewDataCash!.id]!
        }
        
        bgdImgView.translatesAutoresizingMaskIntoConstraints = false
        bgdImgView.layer.cornerRadius = 12
        bgdImgView.layer.borderColor = CGColor(red: 0, green: 1, blue: 244/255, alpha: 1)
        bgdImgView.layer.borderWidth = 2
        
        
        bgdImgView.layer.masksToBounds = true
        view.addSubview(bgdImgView)
        bgdImgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        bgdImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        bgdImgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bgdImgView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        if lessonPreviewDataCash != nil {
            if !lessonPreviewDataCash!.active {
                self.setLock(bgdImgView)
            }
        }
        
        self.setDarkOnImage(bgdImgView)
        self.setTypeOfLesson(lessonPreviewDataCash?.lessonTypeName ?? "", bgdImgView)
        self.setName(lessonPreviewDataCash?.shortName ?? "", bgdImgView)
        self.setTeacherName(lessonPreviewDataCash?.teacherName ?? "", bgdImgView)
        self.setIsAIAvailable(isAIAvailable: lessonPreviewDataCash!.isAIAvailable, parentImgView: bgdImgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDarkOnImage(_ parentImgView: UIImageView){
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        parentImgView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: parentImgView.topAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: parentImgView.bottomAnchor).isActive = true
        shadowView.leadingAnchor.constraint(equalTo: parentImgView.leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: parentImgView.trailingAnchor).isActive = true
    }
    
    
    private func setTypeOfLesson(_ name: String, _ parentImgView: UIImageView) -> (){
        let label: UILabel = UILabel()
        
        let nameMutable = NSMutableAttributedString(string: name)
        nameMutable.addAttribute(NSAttributedString.Key.kern, value: 2.8, range: NSRange(location: 0, length: nameMutable.length - 1))
        
        label.attributedText = nameMutable
        label.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 10)
        label.textColor = .white
        
        parentImgView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: parentImgView.topAnchor, constant: parentImgView.frame.height / 2).isActive = true
        label.centerXAnchor.constraint(equalTo: parentImgView.centerXAnchor).isActive = true
    }
    
    private func setName(_ name: String, _ parentImgView: UIImageView) -> (){
        let label: UILabel = UILabel()
        /*
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : GlobalVariables.activeColor,
          NSAttributedString.Key.foregroundColor : UIColor.white,
          NSAttributedString.Key.strokeWidth : -2.7,
          NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 36)]
          as [NSAttributedString.Key : Any]
        */
        
        //label.attributedText = NSAttributedString(string: name, attributes: strokeTextAttributes)
        label.text = name
        label.font = UIFont(name: GlobalVariables.fontSFTransRoboticsSrc, size: CGFloat(name.count < 15 ? 36 : name.count < 20 ? 28 : 20))
        label.textColor = .white
        
        parentImgView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: parentImgView.topAnchor, constant: parentImgView.frame.height / 2 + 10).isActive = true
        label.centerXAnchor.constraint(equalTo: parentImgView.centerXAnchor).isActive = true
    }
    
    
    private func setTeacherName(_ name: String, _ parentImgView: UIImageView) -> (){
        let label: UILabel = UILabel()
        label.text = name.lowercased()
        label.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 16)
        label.textColor = .white
        parentImgView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: parentImgView.bottomAnchor, constant: -10).isActive = true
        label.trailingAnchor.constraint(equalTo: parentImgView.trailingAnchor, constant: -10).isActive = true
    }
    
    
    
    
    
    private func addName(_ name: String, _ parentImgView: UIImageView, _ lastLabel: UILabel?){
        let label: UILabel = UILabel()
        label.text = name
        label.font = UIFont(name: GlobalVariables.fontMontserratBoldSrc, size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        parentImgView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: parentImgView.leadingAnchor, constant: 15).isActive = true
        if lastLabel != nil {
            label.bottomAnchor.constraint(equalTo: lastLabel!.topAnchor, constant: CGFloat(-self.steYBetweenDescription)).isActive = true
        } else {
            label.bottomAnchor.constraint(equalTo: parentImgView.bottomAnchor, constant: -15).isActive = true
        }
        
    }
    
    private func addDescription(_ content: String?, _ title: String, _ parentImgView: UIImageView, _ lastLabel: UILabel?) -> UILabel? {
        if content == nil { return nil }
        let label: UILabel = UILabel()
        label.text = title + ": " + (String(content ?? ""))
        label.font = UIFont(name: GlobalVariables.fontMontserratBoldSrc, size: 10)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        parentImgView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: parentImgView.leadingAnchor, constant: 15).isActive = true
        if lastLabel != nil {
            label.bottomAnchor.constraint(equalTo: lastLabel!.topAnchor, constant: CGFloat(-self.steYBetweenDescription)).isActive = true
        } else {
            label.bottomAnchor.constraint(equalTo: parentImgView.bottomAnchor, constant: -15).isActive = true
        }
        
        return label
    }
    
    
    
    private func setLock(_ parentImgView: UIImageView){
        let lockBlock = UIView(frame: CGRect())
        lockBlock.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        parentImgView.addSubview(lockBlock)
        lockBlock.translatesAutoresizingMaskIntoConstraints = false
        lockBlock.topAnchor.constraint(equalTo: parentImgView.topAnchor, constant: 10).isActive = true
        lockBlock.trailingAnchor.constraint(equalTo: parentImgView.trailingAnchor, constant: -10).isActive = true
        lockBlock.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lockBlock.widthAnchor.constraint(equalToConstant: 20).isActive = true
        lockBlock.layer.cornerRadius = 2
        
        let lockImg = UIImage(named: "icon-lock")
        let lockImgView = UIImageView(frame: CGRect())
        lockImgView.image = lockImg
        lockImgView.layer.masksToBounds = true
        
        lockBlock.addSubview(lockImgView)
        lockImgView.translatesAutoresizingMaskIntoConstraints = false
        lockImgView.topAnchor.constraint(equalTo: lockBlock.topAnchor, constant: 4).isActive = true
        lockImgView.bottomAnchor.constraint(equalTo: lockBlock.bottomAnchor, constant: -4).isActive = true
        lockImgView.leadingAnchor.constraint(equalTo: lockBlock.leadingAnchor, constant: 4).isActive = true
        lockImgView.trailingAnchor.constraint(equalTo: lockBlock.trailingAnchor, constant: -4).isActive = true
    }
    
    
    private func setIsAIAvailable(isAIAvailable: Bool, parentImgView: UIImageView) -> (){
        let label: UILabel = UILabel()
        label.text = (isAIAvailable ? "AI AVAILABLE" : "AI NOT AVAILABLE")
        label.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        label.textColor = (isAIAvailable ? .white : UIColor(red: 0.588, green: 0.588, blue: 0.588, alpha: 1))
        parentImgView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: parentImgView.bottomAnchor, constant: -10).isActive = true
        label.leadingAnchor.constraint(equalTo: parentImgView.leadingAnchor, constant: 10).isActive = true
    }
}
