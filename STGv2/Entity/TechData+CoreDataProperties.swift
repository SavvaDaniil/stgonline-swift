//
//  TechData+CoreDataProperties.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//
//

import Foundation
import CoreData


extension TechData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TechData> {
        return NSFetchRequest<TechData>(entityName: "TechData")
    }

    @NSManaged public var name: String?
    @NSManaged public var str_value: String?
    @NSManaged public var int_value: Int16

}

extension TechData : Identifiable {

}
