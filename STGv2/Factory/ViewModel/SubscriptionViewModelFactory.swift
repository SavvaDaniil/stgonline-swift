//
//  SubscriptionViewModelFactory.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

class SubscriptionViewModelFactory {
    
    public func createLite(subscriptionLiteModel: SubscriptionLiteModel) -> SubscriptionLiteViewModel {
        return SubscriptionLiteViewModel(
            id: subscriptionLiteModel.id,
            name: subscriptionLiteModel.name,
            price: subscriptionLiteModel.price,
            days: subscriptionLiteModel.days,
            prolongation: subscriptionLiteModel.prolongation,
            price_str: subscriptionLiteModel.price_str
        )
    }
    
}
