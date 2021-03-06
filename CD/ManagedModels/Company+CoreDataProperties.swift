//
//  Company+CoreDataProperties.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: NSSet?

}

// MARK: Generated accessors for mobile
extension Company {

    @objc(addMobileObject:)
    @NSManaged public func addToMobile(_ value: Mobile)

    @objc(removeMobileObject:)
    @NSManaged public func removeFromMobile(_ value: Mobile)

    @objc(addMobile:)
    @NSManaged public func addToMobile(_ values: NSSet)

    @objc(removeMobile:)
    @NSManaged public func removeFromMobile(_ values: NSSet)

}
