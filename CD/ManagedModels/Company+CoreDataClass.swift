//
//  Company+CoreDataClass.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/24/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


public class Company: NSManagedObject, CRUDable {
  static func createCompanyEntity() -> Company {
    return Company(entity: CoreDataHelper.sharedInstance.companyEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }
  
  func createCompany(_ name: String) {
   self.name = name
  }
  
}
