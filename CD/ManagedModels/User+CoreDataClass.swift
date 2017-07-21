//
//  User+CoreDataClass.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import Foundation
import CoreData


public class User: NSManagedObject {

  
  static func createUserEntity() -> User {
    
    return User(entity: CoreDataHelper.sharedInstance.userEntity()!, insertInto: CoreDataHelper.sharedInstance.managedObjectContext)
  }
  
  func createUser(_ name: String) {
    self.name = name
  }
  
  static func getAllUser(withName: String) -> [User] {
    //    let predicate = NSPredicate(
    return CoreDataHelper.sharedInstance.fetchUserArray(withPredicate: nil)!
  }
}
