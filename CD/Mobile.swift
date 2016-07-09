//
//  Mobile.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/9/16.
//  Copyright © 2016 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


class Mobile: NSManagedObject {

  static func createMobileEntity() -> Mobile {
        return Mobile(entity: CoreDataHelper.sharedInstance.mobileEntity()!, insertIntoManagedObjectContext: CoreDataHelper.sharedInstance.managedObjectContext)
    }

    func createMobile(sn: Int, name: String, price: String) {
        self.sn = NSNumber(integer: sn)
        self.name = name
        self.price = name
    }

}
