//
//  LessonsController.swift
//  STGv2
//
//  Created by Daniil Savva on 25.10.2022.
//

import UIKit


class LessonsController : UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Это окно LessonsController"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var topNavBar: TopNavBar?
    private var lessonPreviewsView: LessonPreviewsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        let topNavBarFactory = TopNavBarFactory()
        topNavBar = topNavBarFactory.create(parentController: self, titleText: "Уроки")
        
        lessonPreviewsView = LessonPreviewsView(context: self.context, parentController: self)
        self.view.addSubview(lessonPreviewsView!)
        lessonPreviewsView!.topAnchor.constraint(equalTo: topNavBar!.bottomAnchor).isActive = true
        lessonPreviewsView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        lessonPreviewsView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        lessonPreviewsView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        lessonPreviewsView!.setup()
        
    }
    
    public func setup(){
        self.lessonPreviewsView?.setup()
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
