//
//  Mobile+CoreDataProperties.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/9/16.
//  Copyright © 2016 Sanjay Maharjan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Mobile {

    @NSManaged var sn: String?
    @NSManaged var name: String?
    @NSManaged var price: String?

}
