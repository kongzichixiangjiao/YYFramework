//
//  GATestModel+CoreDataProperties.swift
//  
//
//  Created by houjianan on 2020/2/24.
//
//

import Foundation
import CoreData


extension GATestModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GATestModel> {
        return NSFetchRequest<GATestModel>(entityName: "GATestModel")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var number: Int16
    @NSManaged public var time: Date?
    @NSManaged public var image: NSObject?

}
