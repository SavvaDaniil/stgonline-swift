//
//  SubscriptionViewModel.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

class SubscriptionLiteModel : Decodable {
    var id: Int
    var name: String?
    var price: Int = 0
    var days: Int = 0
    var prolongation: Bool = false
    var price_str: String?
}
