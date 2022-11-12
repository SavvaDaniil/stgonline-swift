//
//  UserService.swift
//  STGv2
//
//  Created by Daniil Savva on 27.10.2022.
//

import Foundation

class UserService {
    
    public func login(jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate, username: String, password: String){
        
        let json: [String: Any] = [
            "username": username,
            "password" : password
        ]
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/login")!
        self.postRequest(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, url: url, json: json)
    }
    
    
    public func registration(jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate, username: String, password: String){
        
        let json: [String: Any] = [
            "username": username,
            "password" : password
        ]
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/registration")!
        self.postRequest(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, url: url, json: json)
    }
    
    public func forget(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate,
        step: Int,
        username: String,
        forget_id: Int,
        code: String
    ){
        
        let json: [String: Any] = [
            "step": step,
            "username" : username,
            "forget_id" : forget_id,
            "code" : code
        ]
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/forget")!
        self.postRequest(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, url: url, json: json)
    }
    
    public func listAllPurchaseLites(
        purchaseLitesFetchCallbackDelegate: PurchaseLitesFetchCallbackDelegate,
        jwt: String
    ){
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/list_all_purchase_lites")!
        self.postRequest(purchaseLitesFetchCallbackDelegate: purchaseLitesFetchCallbackDelegate, url: url, json: nil, jwt: jwt)
    }
    
    public func profileGet(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate,
        jwt: String
    ){
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/profile/get")!
        self.postRequest(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, url: url, json: nil, jwt: jwt)
    }
    
    public func profileUpdate(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate,
        jwt: String,
        username: String,
        passwordNew: String,
        passwordCurrent: String
    ){
        
        let json: [String: Any] = [
            "username" : username,
            "password_new" : passwordNew,
            "password_current" : passwordCurrent
        ]
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/profile/update")!
        self.postRequest(jsonAnswerStatusCallbackDelegate: jsonAnswerStatusCallbackDelegate, url: url, json: json, jwt: jwt)
    }
    
    private func postRequest(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate? = nil,
        purchaseLitesFetchCallbackDelegate: PurchaseLitesFetchCallbackDelegate? = nil,
        url: URL,
        json: [String: Any]?,
        jwt: String? = nil
    ){
        
        //let url = URL(string: GlobalVariables.baseDomain + "/api/user/registration")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if json != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: json!)
            request.httpBody = jsonData
        }
        if jwt != nil {
            request.setValue( "Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "Unknown error")
                    DispatchQueue.main.async {
                        if jsonAnswerStatusCallbackDelegate != nil {
                            jsonAnswerStatusCallbackDelegate?.jsonAnswerStatusCallback(jsonAnswerStatus: nil, isNetError: true)
                        }
                        if purchaseLitesFetchCallbackDelegate != nil {
                            purchaseLitesFetchCallbackDelegate?.purchaseLitesFetchCallback(jsonAnswerStatus: nil, isNetError: true)
                        }
                    }
                    return
                }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async {
                    if jsonAnswerStatusCallbackDelegate != nil {
                        jsonAnswerStatusCallbackDelegate?.jsonAnswerStatusCallback(jsonAnswerStatus: nil, isNetError: false)
                    }
                    if purchaseLitesFetchCallbackDelegate != nil {
                        purchaseLitesFetchCallbackDelegate?.purchaseLitesFetchCallback(jsonAnswerStatus: nil, isNetError: false)
                    }
                }
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            //print("UserService responseString = \(String(describing: responseString))")
            
            let jsonData = responseString?.data(using: .utf8)
            if jsonData == nil {
                return
            }
            let jsonAnswerStatus: JsonAnswerStatus = try! JSONDecoder().decode(JsonAnswerStatus.self, from: jsonData!)
            
            DispatchQueue.main.async {
                if jsonAnswerStatusCallbackDelegate != nil {
                    jsonAnswerStatusCallbackDelegate?.jsonAnswerStatusCallback(jsonAnswerStatus: jsonAnswerStatus, isNetError: false)
                }
                if purchaseLitesFetchCallbackDelegate != nil {
                    purchaseLitesFetchCallbackDelegate?.purchaseLitesFetchCallback(jsonAnswerStatus: jsonAnswerStatus, isNetError: false)
                }
            }
        }

        task.resume()
    }
    
    
}
