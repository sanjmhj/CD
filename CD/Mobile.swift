//
//  Mobile.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/9/16.
//  Copyright © 2016 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData

protocol CRUDable: class {
  
}


class Mobile: NSManagedObject {
  static func createMobileEntity() -> Mobile {
    return Mobile(entity: CoreDataHelper.sharedInstance.mobileEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }

  func createMobile(_ sn: String, name: String, price: String) {
    self.sn = sn
    self.name = name
    self.price = price
  }

}
extension Mobile: CRUDable {
  func delete() {
    CoreDataHelper.sharedInstance.managedObjectContext.delete(self)
    CoreDataHelper.sharedInstance.saveMainContext()
  }
}
