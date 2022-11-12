//
//  JsonAnswerStatusCallbackDelegate.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//

protocol JsonAnswerStatusCallbackDelegate {
    func jsonAnswerStatusCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool)
}
