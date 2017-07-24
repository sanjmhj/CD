//
//  User+CoreDataProperties.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/24/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var book: Mobile?

}
