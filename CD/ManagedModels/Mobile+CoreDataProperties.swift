//
//  Mobile+CoreDataProperties.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/24/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


extension Mobile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mobile> {
        return NSFetchRequest<Mobile>(entityName: "Mobile")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var sn: NSNumber?
    @NSManaged public var companys: Company?
    @NSManaged public var user: User?

}
