//
//  LessonPreviewsView.swift
//  STGv2
//
//  Created by Daniil Savva on 01.11.2022.
//

import CoreData
import UIKit

class LessonPreviewsView : UIView, UITableViewDelegate, UITableViewDataSource, LessonSearchCallbackDelegate, FooterLessonPreviewsTableDelegate {
    
    private var context: NSManagedObjectContext
    
    private var lessonPreviewTableView: UITableView?
    private var footerLessonPreviewsTableView: FooterLessonPreviewsTableView?
    private var parentController: UIViewController
    private let userFacade: UserFacade = UserFacade()
    private let lessonFacade: LessonFacade = LessonFacade()
    private var isLoading: Bool = false
    //private let lessonAboutController = LessonAboutController()
    
    required init(context: NSManagedObjectContext, parentController: UIViewController){
        self.context = context
        self.parentController = parentController
        //footerLoadingView = UIView(frame: CGRect(x: 0, y: 0, width: parentController.view.frame.width, height: 50))
        super.init(frame: CGRect())
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        lessonPreviewTableView = UITableView(frame: CGRect(), style: UITableView.Style.plain)
        lessonPreviewTableView!.translatesAutoresizingMaskIntoConstraints = false
        lessonPreviewTableView!.backgroundColor = UIColor(white: 1, alpha: 0)
        lessonPreviewTableView!.separatorStyle = .none
        lessonPreviewTableView!.bounces = false
        lessonPreviewTableView!.rowHeight = UIScreen.main.bounds.width * 9 / 16
        self.addSubview(lessonPreviewTableView!)
        lessonPreviewTableView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lessonPreviewTableView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lessonPreviewTableView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lessonPreviewTableView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        lessonPreviewTableView!.delegate = self
        lessonPreviewTableView!.dataSource = self
        lessonPreviewTableView!.register(LessonPreviewTableViewCell.self, forCellReuseIdentifier: "cellLessonPreview")
        
        
        /*
        let footerLoadingViewTitle = UILabel(frame: CGRect())
        footerLoadingViewTitle.font = UIFont(name: GlobalVariables.fontGothamProMediumSrc, size: 14)
        footerLoadingViewTitle.text = "Идет загрузка..."
        footerLoadingViewTitle.textColor = .white
        footerLoadingView.addSubview(footerLoadingViewTitle)
        footerLoadingViewTitle.translatesAutoresizingMaskIntoConstraints = false
        footerLoadingViewTitle.centerXAnchor.constraint(equalTo: footerLoadingView.centerXAnchor).isActive = true
        footerLoadingViewTitle.centerYAnchor.constraint(equalTo: footerLoadingView.centerYAnchor).isActive = true
        */
        self.footerLessonPreviewsTableView = FooterLessonPreviewsTableView(parentController: self.parentController, footerLessonPreviewsTableDelegate: self)
        lessonPreviewTableView!.tableFooterView = self.footerLessonPreviewsTableView!
        
        //GlobalVariables.unixTimeStatusForFetchingLessonPreviews = Int(NSDate().timeIntervalSince1970)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(){
        //lessonFacade.search(lessonSearchCallbackDelegate: self)
        GlobalVariables.lessonPreviewsDataCash = []
        self.initSearching()
    }
    
    private func initSearching(){
        if self.isLoading {
            return
        }
        print("LessonPreviewsView initSearching()")
        let jwt: String? = self.userFacade.getJwt(context: self.context)
        self.isLoading = true
        self.setLoadingStatus(true)
        lessonFacade.search(lessonSearchCallbackDelegate: self, jwt: jwt)
    }
    
    private func setLoadingStatus(_ value: Bool){
        if GlobalVariables.gotMaxLessonPreviews {
            self.footerLessonPreviewsTableView?.setFooterState(footerLessonPreviewsTableState: .READY)
        } else {
            self.footerLessonPreviewsTableView?.setFooterState(footerLessonPreviewsTableState: .LOADING)
        }
    }
    
    public func updateAfterChangeAuth(){
        //self.skip = 0
        GlobalVariables.gotMaxLessonPreviews = false
        GlobalVariables.lessonPreviewsDataCash.removeAll()
        GlobalVariables.unixTimeStatusForFetchingLessonPreviews = Int(NSDate().timeIntervalSince1970)
        lessonPreviewTableView!.reloadData()
        //_lessonFacade.searchFromBegin(GlobalVariables.unixTimeLessonsTableViewActual, self, _id_of_level, _skip)
    }
    
    internal func lessonSearchCallback(isError: Bool = false) {
        self.isLoading = false
        self.setLoadingStatus(false)
        if isError {
            self.footerLessonPreviewsTableView?.setFooterState(footerLessonPreviewsTableState: .ERROR)
        } else {
            self.footerLessonPreviewsTableView?.setFooterState(footerLessonPreviewsTableState: .READY)
            DispatchQueue.main.async {
                self.lessonPreviewTableView!.reloadData()
            }
        }
    }
    
    
    internal func tryAgain() {
        self.initSearching()
    }
}


extension LessonPreviewsView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalVariables.lessonPreviewsDataCash.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LessonPreviewTableViewCell(
            lessonPreviewDataCash: GlobalVariables.lessonPreviewsDataCash[indexPath.row],
            parentView: self.parentController.view
        )
        cell.backgroundColor = UIColor(white: 1, alpha: 0)
        //cell.heightAnchor.constraint(equalToConstant: CGFloat(self.frame.width * 9 / 16)).isActive = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lessonAboutController = LessonAboutController()
        lessonAboutController.prepare(lessonId: GlobalVariables.lessonPreviewsDataCash[indexPath.row].id)
        self.parentController.presentFromRight(vc: lessonAboutController)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 2 == GlobalVariables.lessonPreviewsDataCash.count && GlobalVariables.lessonPreviewsDataCash.count > 4 {
            //обнолвяем уроки
            print("Обновляем уроки")
            self.initSearching()
            //_lessonFacade.search(self, self._id_of_level, self._skip)
        }
    }
}
