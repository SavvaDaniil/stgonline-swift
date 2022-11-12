//
//  LessonFacade.swift
//  STGv2
//
//  Created by Daniil Savva on 01.11.2022.
//

import Foundation
import UIKit

class LessonFacade : JsonAnswerStatusCallbackDelegate, LessonSearchFetchCallbackDelegate {
    
    private var lessonSearchCallbackDelegate: LessonSearchCallbackDelegate?
    private var lessonGetLiteFetchCallbackDelegate: LessonGetLiteFetchCallbackDelegate?
    private var unixTimeStatus: Int = Int(NSDate().timeIntervalSince1970)
    
    public func checkAccess(
        lessonCheckAccessFetchCallbackDelegate: LessonCheckAccessFetchCallbackDelegate,
        lessonId: Int,
        jwt: String? = nil
    ){
        //userService.profileGet(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, jwt: jwt)
        let lessonService: LessonService = LessonService()
        lessonService.checkAccess(
            lessonCheckAccessFetchCallbackDelegate: lessonCheckAccessFetchCallbackDelegate,
            lessonId: lessonId,
            jwt: jwt
        )
    }
    
    
    public func getLite(
        lessonGetLiteFetchCallbackDelegate: LessonGetLiteFetchCallbackDelegate,
        lessonId: Int,
        jwt: String? = nil
    ){
        //userService.profileGet(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, jwt: jwt)
        let lessonService: LessonService = LessonService()
        lessonService.getLite(
            lessonGetLiteFetchCallbackDelegate: lessonGetLiteFetchCallbackDelegate,
            lessonId: lessonId,
            jwt: jwt
        )
    }
    
    public func search(
        lessonSearchCallbackDelegate: LessonSearchCallbackDelegate,
        jwt: String? = nil
    ){
        if GlobalVariables.isLessonPreviewsFetching {
            print("LessonService Сброс поиска, загрузка поиска или картинок еще идет")
            return
        }
        
        if GlobalVariables.gotMaxLessonPreviews {
            print("--- Больше уроков нет на сервере")
            return
        }
        print("LessonFacade search jwt: \(jwt)")
        GlobalVariables.isLessonPreviewsFetching = true
        self.lessonSearchCallbackDelegate = lessonSearchCallbackDelegate
        
        GlobalVariables.unixTimeStatusForFetchingLessonPreviews = Int(NSDate().timeIntervalSince1970)
        self.unixTimeStatus = GlobalVariables.unixTimeStatusForFetchingLessonPreviews
        let lessonService: LessonService = LessonService()
        lessonService.search(lessonSearchFetchCallbackDelegate: self, jwt: jwt)
    }
    
    internal func jsonAnswerStatusCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool) {
        //GlobalVariables.isLessonPreviewsFetching = false
        
    }
    
    internal func lessonSearchFetchCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool) {
        //GlobalVariables.isLessonPreviewsFetching = false
        if jsonAnswerStatus == nil || isNetError {
            print("lessonSearchCallback Ошибка сети")
            GlobalVariables.isLessonPreviewsFetching = false
            self.lessonSearchCallbackDelegate!.lessonSearchCallback(isError: true)
            return
        }
        
        if jsonAnswerStatus?.status == "success" && jsonAnswerStatus?.lessonPreviewViewModels != nil {
            let lessonViewModelFactory: LessonViewModelFactory = LessonViewModelFactory()
            let lessonPreviewViewModels: [LessonPreviewViewModel] = lessonViewModelFactory.createPreviewsList(lessonPreviewModels: (jsonAnswerStatus?.lessonPreviewViewModels)!)
            
            
            self.prepareLessonPreviewToGlobalVariablesAndLoadImage(lessonPreviewViewModels: lessonPreviewViewModels, index: 0)
        } else {
            print("lessonSearchCallback Ошибка сети")
            GlobalVariables.isLessonPreviewsFetching = false
            self.lessonSearchCallbackDelegate!.lessonSearchCallback(isError: true)
            return
        }
        
    }
    
    
    private func prepareLessonPreviewToGlobalVariablesAndLoadImage(lessonPreviewViewModels: [LessonPreviewViewModel], index: Int){
        
        //for lessonPreviewViewModel: LessonPreviewViewModel in lessonPreviewViewModels {
        
        if lessonPreviewViewModels.count == 0 {
            print("Достигнут предел выборки для данного фильтра")
            GlobalVariables.gotMaxLessonPreviews = true
            GlobalVariables.isLessonPreviewsFetching = false
            self.lessonSearchCallbackDelegate!.lessonSearchCallback(isError: false)
            return
        }
        
        //нужно загружать модели в оперативную память, параллельно запускать загрузку картинок
        
        if self.unixTimeStatus != GlobalVariables.unixTimeStatusForFetchingLessonPreviews {
            print("Сброс загрузки оставшихся картинок")
            GlobalVariables.isLessonPreviewsFetching = false
            self.lessonSearchCallbackDelegate!.lessonSearchCallback(isError: false)
            return
        }
        
        if index > (lessonPreviewViewModels.count - 1) {
            print("Все загрузки картинок и превью уроков завершены")
            GlobalVariables.isLessonPreviewsFetching = false
            self.lessonSearchCallbackDelegate!.lessonSearchCallback(isError: false)
            return
        }
        
        let lessonPreviewViewModel = lessonPreviewViewModels[index]
        print("Работаем с lessonPreviewViewModel: \(lessonPreviewViewModel.id)")
        
        if lessonPreviewViewModel.poster_src == nil {
            self.addLessonPreviewInGlobalVariables(lessonPreviewViewModel: lessonPreviewViewModel, posterImage: nil)
            self.prepareLessonPreviewToGlobalVariablesAndLoadImage(lessonPreviewViewModels: lessonPreviewViewModels, index: index+1)
            return
        }
        if lessonPreviewViewModel.poster_src == "" {
            self.addLessonPreviewInGlobalVariables(lessonPreviewViewModel: lessonPreviewViewModel, posterImage: nil)
            self.prepareLessonPreviewToGlobalVariablesAndLoadImage(lessonPreviewViewModels: lessonPreviewViewModels, index: index+1)
            return
        }
        
        
        let url: URL = URL(string: lessonPreviewViewModel.poster_src!)!
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [self] in
            getData(from: url) { data, response, error in
                print("Закончилась загрузка картинки для id: \(lessonPreviewViewModel.id)")
                guard let data = data, error == nil else {
                    
                    print("Ошибка связи: \(error.debugDescription)")
                    if self.unixTimeStatus != GlobalVariables.unixTimeStatusForFetchingLessonPreviews {
                        print("Сброс загрузки картинок")
                        return
                    }
                    
                    //lessonSearchDelegate.lessonSearchCallback(nil)
                    self.addLessonPreviewInGlobalVariables(lessonPreviewViewModel: lessonPreviewViewModel, posterImage: nil)
                    self.prepareLessonPreviewToGlobalVariablesAndLoadImage(lessonPreviewViewModels: lessonPreviewViewModels, index: index + 1)
                    return
                }
                
                DispatchQueue.main.async() {
                    if self.unixTimeStatus != GlobalVariables.unixTimeStatusForFetchingLessonPreviews {
                        print("Сброс загрузки картинок")
                        return
                    }
                    
                    //lessonSearchDelegate.lessonSearchCallback(nil)
                    self.addLessonPreviewInGlobalVariables(lessonPreviewViewModel: lessonPreviewViewModel, posterImage: UIImage(data: data))
                    self.prepareLessonPreviewToGlobalVariablesAndLoadImage(lessonPreviewViewModels: lessonPreviewViewModels, index: index + 1)
                }
                
            }
        }
    }
    
    
    
    private func addLessonPreviewInGlobalVariables(lessonPreviewViewModel: LessonPreviewViewModel, posterImage: UIImage?){
        
        GlobalVariables.lessonPreviewsDataCash.append(
            LessonPreviewDataCash(
                id: lessonPreviewViewModel.id,
                name: lessonPreviewViewModel.name ?? "",
                shortName: lessonPreviewViewModel.short_name ?? "",
                active: lessonPreviewViewModel.active,
                isAIAvailable: lessonPreviewViewModel.is_ai_available,
                levelName: lessonPreviewViewModel.level_name,
                lessonTypeName: lessonPreviewViewModel.lesson_type_name,
                styleName: lessonPreviewViewModel.style_name,
                teacherName: lessonPreviewViewModel.teacher_name,
                posterSrc: lessonPreviewViewModel.poster_src
            )
        )
        
        if posterImage != nil {
            GlobalVariables.lessonImagesDataCash[lessonPreviewViewModel.id] = posterImage
        }
        
        if self.lessonSearchCallbackDelegate != nil {
            self.lessonSearchCallbackDelegate!.lessonSearchCallback(isError: false)
        }
    }
    
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
