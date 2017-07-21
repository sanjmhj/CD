//
//  Manufacturer+CoreDataClass.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


public class Manufacturer: NSManagedObject {
  
  static func createManufacturerEntity() -> Manufacturer {
    
    return Manufacturer(entity: CoreDataHelper.sharedInstance.manufacturerEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }
  
  func createManufacturer(_ name: String) {
    self.name = name
  }
  
  static func getAllManufacturer(withName: String) -> [Manufacturer] {
//    let predicate = NSPredicate(
    return CoreDataHelper.sharedInstance.fetchManufacturerArray(withPredicate: nil)!
  }

}
