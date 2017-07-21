//
//  Mobile+CoreDataClass.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData

protocol CRUDable: class {
  func delete()
}


public class Mobile: NSManagedObject {
  static func createMobileEntity() -> Mobile {
    return Mobile(entity: CoreDataHelper.sharedInstance.mobileEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }
  
  func createMobile(_ sn: String, name: String, price: String, manufacturer: Manufacturer) {
    
    self.sn = Int(sn)! as NSNumber
    self.name = name
    self.price = price
    self.manufacturer = manufacturer
  }
  
}
extension NSManagedObject: CRUDable {
  func delete() {
    CoreDataHelper.sharedInstance.managedObjectContext.delete(self)
    CoreDataHelper.sharedInstance.saveMainContext()
  }
}
