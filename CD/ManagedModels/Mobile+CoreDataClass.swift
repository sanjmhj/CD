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

extension CRUDable where Self: NSManagedObject {
  func delete() {
    CoreDataHelper.sharedInstance.managedObjectContext.delete(self)
    CoreDataHelper.sharedInstance.saveMainContext()
  }
}


public class Mobile: NSManagedObject, CRUDable {
  static func createMobileEntity() -> Mobile {
    return Mobile(entity: CoreDataHelper.sharedInstance.mobileEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }
  
  func createMobile(_ sn: String, name: String, price: String, user: User, company: Company) {
    
    self.sn = Int(sn)! as NSNumber
    self.name = name
    self.price = price
    self.user = user
    self.companys = company
  }
  
}
