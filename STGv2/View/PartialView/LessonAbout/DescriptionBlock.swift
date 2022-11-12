//
//  DescriptionBlock.swift
//  STGv2
//
//  Created by Daniil Savva on 03.11.2022.
//

import UIKit

class DescriptionBlock : UIView {
    
    private var nameTitle: UILabel = UILabel(frame: CGRect())
    private var nameValue: UILabel = UILabel(frame: CGRect())
    
    private var musicTitle: UILabel = UILabel(frame: CGRect())
    private var musicValue: UILabel = UILabel(frame: CGRect())
    
    private var styleTitle: UILabel = UILabel(frame: CGRect())
    private var styleValue: UILabel = UILabel(frame: CGRect())
    
    private var teacherTitle: UILabel = UILabel(frame: CGRect())
    private var teacherValue: UILabel = UILabel(frame: CGRect())
    
    private var priceTitle: UILabel = UILabel(frame: CGRect())
    private var priceValue: UILabel = UILabel(frame: CGRect())
    
    required init(){
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.1)
        self.layer.borderColor = GlobalVariables.grayColor.cgColor
        self.layer.cornerRadius = 12
        
        self.nameTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.nameTitle.textColor = GlobalVariables.activeColor
        self.nameTitle.text = "Наименование: "
        self.addSubview(self.nameTitle)
        self.nameTitle.translatesAutoresizingMaskIntoConstraints = false
        self.nameTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.nameTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        //self.nameTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.nameTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.nameTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.nameValue.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        self.nameValue.textColor = .white
        self.nameValue.text = ""
        //self.nameValue.numberOfLines = 2
        //self.nameValue.lineBreakMode = .byWordWrapping
        self.addSubview(self.nameValue)
        self.nameValue.translatesAutoresizingMaskIntoConstraints = false
        self.nameValue.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.nameValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.nameValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.nameValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        self.musicTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.musicTitle.textColor = GlobalVariables.activeColor
        self.musicTitle.text = "Музыка: "
        self.addSubview(self.musicTitle)
        self.musicTitle.translatesAutoresizingMaskIntoConstraints = false
        self.musicTitle.topAnchor.constraint(equalTo: nameValue.bottomAnchor, constant: 0).isActive = true
        self.musicTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        //self.nameTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.musicTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.musicTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.musicValue.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        self.musicValue.textColor = .white
        self.musicValue.text = ""
        //self.nameValue.numberOfLines = 2
        //self.nameValue.lineBreakMode = .byWordWrapping
        self.addSubview(self.musicValue)
        self.musicValue.translatesAutoresizingMaskIntoConstraints = false
        self.musicValue.topAnchor.constraint(equalTo: nameValue.bottomAnchor, constant: 0).isActive = true
        self.musicValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.musicValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.musicValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        self.styleTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.styleTitle.textColor = GlobalVariables.activeColor
        self.styleTitle.text = "Стиль: "
        self.addSubview(self.styleTitle)
        self.styleTitle.translatesAutoresizingMaskIntoConstraints = false
        self.styleTitle.topAnchor.constraint(equalTo: musicValue.bottomAnchor, constant: 0).isActive = true
        self.styleTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.styleTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.styleTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.styleValue.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        self.styleValue.textColor = .white
        self.styleValue.text = ""
        //self.nameValue.numberOfLines = 2
        //self.nameValue.lineBreakMode = .byWordWrapping
        self.addSubview(self.styleValue)
        self.styleValue.translatesAutoresizingMaskIntoConstraints = false
        self.styleValue.topAnchor.constraint(equalTo: musicValue.bottomAnchor, constant: 0).isActive = true
        self.styleValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.styleValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.styleValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
       
        self.teacherTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.teacherTitle.textColor = GlobalVariables.activeColor
        self.teacherTitle.text = "Преподаватель: "
        self.addSubview(self.teacherTitle)
        self.teacherTitle.translatesAutoresizingMaskIntoConstraints = false
        self.teacherTitle.topAnchor.constraint(equalTo: styleValue.bottomAnchor, constant: 0).isActive = true
        self.teacherTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        //self.nameTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.teacherTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.teacherTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.teacherValue.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        self.teacherValue.textColor = .white
        self.teacherValue.text = ""
        self.teacherValue.lineBreakMode = .byWordWrapping
        self.addSubview(self.teacherValue)
        self.teacherValue.translatesAutoresizingMaskIntoConstraints = false
        self.teacherValue.topAnchor.constraint(equalTo: styleValue.bottomAnchor, constant: 0).isActive = true
        self.teacherValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.teacherValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.teacherValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        self.priceTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 12)
        self.priceTitle.textColor = GlobalVariables.activeColor
        self.priceTitle.text = "Стоимость: "
        self.addSubview(self.priceTitle)
        self.priceTitle.translatesAutoresizingMaskIntoConstraints = false
        self.priceTitle.topAnchor.constraint(equalTo: teacherValue.bottomAnchor, constant: 0).isActive = true
        self.priceTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.priceTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.priceTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.priceValue.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 12)
        self.priceValue.textColor = .white
        self.priceValue.text = ""
        self.priceValue.lineBreakMode = .byWordWrapping
        self.addSubview(self.priceValue)
        self.priceValue.translatesAutoresizingMaskIntoConstraints = false
        self.priceValue.topAnchor.constraint(equalTo: teacherValue.bottomAnchor, constant: 0).isActive = true
        self.priceValue.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        self.priceValue.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        self.priceValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    public func setName(name: String){
        self.nameValue.text = "                            " + name
    }
    public func setMusicName(musicName: String){
        self.musicValue.text = "                " + musicName
    }
    public func setStyleName(styleName: String){
        self.styleValue.text = "                " + styleName
    }
    public func setTeacherName(name: String){
        self.teacherValue.text = "                             " + name
    }
    public func setIsActive(value: Bool){
        self.priceTitle.isHidden = value
        self.priceValue.isHidden = value
    }
    public func setPrice(price: String){
        self.priceValue.text = "                     " + price
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
