//
//  LessonService.swift
//  STGv2
//
//  Created by Daniil Savva on 01.11.2022.
//

import Foundation

class LessonService {
    
    public func search(lessonSearchFetchCallbackDelegate: LessonSearchFetchCallbackDelegate, jwt: String? = nil) -> () {
        let json: [String: Any] = [
            "skip": GlobalVariables.lessonPreviewsDataCash.count
        ]
        print("LessonService skip: \(GlobalVariables.lessonPreviewsDataCash.count)")
        let url = URL(string: GlobalVariables.baseDomain + "/api/lesson/search")!
        
        self.postRequest(
            lessonSearchFetchCallbackDelegate: lessonSearchFetchCallbackDelegate,
            url: url,
            json: json,
            jwt: jwt
        )
    }
    
    public func checkAccess(
        lessonCheckAccessFetchCallbackDelegate: LessonCheckAccessFetchCallbackDelegate,
        lessonId: Int,
        jwt: String? = nil
    ) -> () {
        let json: [String: Any] = [
            "lesson_id": lessonId
        ]
        let url = URL(string: GlobalVariables.baseDomain + "/api/lesson/check_access")!
        
        self.postRequest(
            lessonCheckAccessFetchCallbackDelegate: lessonCheckAccessFetchCallbackDelegate,
            url: url,
            json: json,
            jwt: jwt
        )
    }
    
    public func getLite(
        lessonGetLiteFetchCallbackDelegate: LessonGetLiteFetchCallbackDelegate,
        lessonId: Int,
        jwt: String? = nil
    ) -> () {
        let json: [String: Any] = [
            "lesson_id": lessonId
        ]
        let url = URL(string: GlobalVariables.baseDomain + "/api/lesson/get_lite")!
        
        self.postRequest(
            lessonGetLiteFetchCallbackDelegate: lessonGetLiteFetchCallbackDelegate,
            url: url,
            json: json,
            jwt: jwt
        )
    }
    
    func readCookie(forURL url: URL) -> [HTTPCookie] {
        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: url) ?? []
        return cookies
    }
    
    public func postRequest(
        lessonSearchFetchCallbackDelegate: LessonSearchFetchCallbackDelegate? = nil,
        lessonGetLiteFetchCallbackDelegate: LessonGetLiteFetchCallbackDelegate? = nil,
        lessonCheckAccessFetchCallbackDelegate: LessonCheckAccessFetchCallbackDelegate? = nil,
        url: URL,
        json: [String: Any]?,
        jwt: String? = nil
    ) -> () {
        
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in readCookie(forURL: url) {
            cookieStorage.deleteCookie(cookie)
        }
        
        //let url = URL(string: GlobalVariables.baseDomain + "/api/user/registration")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if json != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: json!)
            request.httpBody = jsonData
        }
        if jwt != nil {
            request.setValue("Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        }
        //print("LessonService postRequest jwt: \(jwt)")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "Unknown error")
                    DispatchQueue.main.async {
                        if lessonSearchFetchCallbackDelegate != nil {
                            lessonSearchFetchCallbackDelegate!.lessonSearchFetchCallback(jsonAnswerStatus: nil, isNetError: true)
                        }
                        if lessonGetLiteFetchCallbackDelegate != nil {
                            lessonGetLiteFetchCallbackDelegate!.lessonGetLiteFetchCallback(jsonAnswerStatus: nil, isNetError: true)
                        }
                        if lessonCheckAccessFetchCallbackDelegate != nil {
                            lessonCheckAccessFetchCallbackDelegate!.lessonCheckAccessFetchCallback(jsonAnswerStatus: nil, isNetError: true)
                        }
                    }
                    return
                }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async {
                    if lessonSearchFetchCallbackDelegate != nil {
                        lessonSearchFetchCallbackDelegate!.lessonSearchFetchCallback(jsonAnswerStatus: nil, isNetError: false)
                    }
                    if lessonGetLiteFetchCallbackDelegate != nil {
                        lessonGetLiteFetchCallbackDelegate!.lessonGetLiteFetchCallback(jsonAnswerStatus: nil, isNetError: false)
                    }
                    if lessonCheckAccessFetchCallbackDelegate != nil {
                        lessonCheckAccessFetchCallbackDelegate!.lessonCheckAccessFetchCallback(jsonAnswerStatus: nil, isNetError: false)
                    }
                }
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("LessonService postRequest = \(String(describing: responseString))")
            
            let jsonData = responseString?.data(using: .utf8)
            if jsonData == nil {
                return
            }
            let jsonAnswerStatus: JsonAnswerStatus = try! JSONDecoder().decode(JsonAnswerStatus.self, from: jsonData!)
            
            DispatchQueue.main.async {
                if lessonSearchFetchCallbackDelegate != nil {
                    lessonSearchFetchCallbackDelegate!.lessonSearchFetchCallback(jsonAnswerStatus: jsonAnswerStatus, isNetError: false)
                }
                if lessonGetLiteFetchCallbackDelegate != nil {
                    lessonGetLiteFetchCallbackDelegate!.lessonGetLiteFetchCallback(jsonAnswerStatus: jsonAnswerStatus, isNetError: false)
                }
                if lessonCheckAccessFetchCallbackDelegate != nil {
                    lessonCheckAccessFetchCallbackDelegate!.lessonCheckAccessFetchCallback(jsonAnswerStatus: jsonAnswerStatus, isNetError: false)
                }
            }
        }

        task.resume()
    }
}
