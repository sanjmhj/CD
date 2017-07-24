//
//  Company+CoreDataProperties.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/24/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: Mobile?

}
