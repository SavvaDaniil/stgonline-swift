//
//  JsonAnswerStatusRequestComponent.swift
//  STGv2
//
//  Created by Daniil Savva on 01.11.2022.
//

import Foundation

class JsonAnswerStatusRequestComponent {
    
    public func post(
        jsonAnswerStatusCallbackDelegate: JsonAnswerStatusCallbackDelegate? = nil,
        url: URL,
        json: [String: Any]?
    ){
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if json != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: json!)
            request.httpBody = jsonData
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "Unknown error")
                    DispatchQueue.main.async {
                        if jsonAnswerStatusCallbackDelegate != nil {
                            jsonAnswerStatusCallbackDelegate!.jsonAnswerStatusCallback(jsonAnswerStatus: nil, isNetError: true)
                        }
                    }
                    return
                }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async {
                    if jsonAnswerStatusCallbackDelegate != nil {
                        jsonAnswerStatusCallbackDelegate!.jsonAnswerStatusCallback(jsonAnswerStatus: nil, isNetError: false)
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
                    jsonAnswerStatusCallbackDelegate!.jsonAnswerStatusCallback(jsonAnswerStatus: jsonAnswerStatus, isNetError: false)
                }
            }
        }

        task.resume()
    }
}
