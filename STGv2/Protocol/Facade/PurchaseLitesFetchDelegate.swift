//
//  PurchaseLitesFetchDelegate.swift
//  STGv2
//
//  Created by Daniil Savva on 07.11.2022.
//


protocol PurchaseLitesFetchCallbackDelegate {
    func purchaseLitesFetchCallback(jsonAnswerStatus: JsonAnswerStatus?, isNetError: Bool)
}
protocol PurchaseLitesCallbackDelegate {
    func purchaseLitesCallback(isNetError: Bool)
}
