//
//  Company+CoreDataClass.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


public class Company: NSManagedObject {
  static func createUserEntity() -> Company {
    
    return Company(entity: CoreDataHelper.sharedInstance.companyEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }
  
  func createUser(_ name: String) {
    self.name = name
  }
  
  static func getAllUser(withName: String) -> [Company] {
    //    let predicate = NSPredicate(
    return CoreDataHelper.sharedInstance.fetchCompanyArray(withPredicate: nil)!
  }
}
