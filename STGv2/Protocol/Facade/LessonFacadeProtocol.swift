//
//  LessonFacadeProtocol.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//

protocol LessonSearchCallbackDelegate {
    func lessonSearchCallback(isError: Bool)
}

protocol LessonSearchFetchCallbackDelegate {
    func lessonSearchFetchCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool)
}

protocol LessonGetLiteFetchCallbackDelegate {
    func lessonGetLiteFetchCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool)
}

protocol LessonCheckAccessFetchCallbackDelegate {
    func lessonCheckAccessFetchCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool)
}

protocol LessonCheckAccessDelegate {
    func lessonCheckAccess()
}
