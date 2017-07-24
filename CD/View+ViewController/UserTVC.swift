//
//  UserTVC.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import UIKit
protocol UserTVCDelegate {
  func selected(_ selected: User)
}

class UserTVC: UITableViewController {
  var userList = [User]()
  var additionAlert: UIAlertController!
  
  var userTVCDelegate: UserTVCDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
    title = "User List"
    self.navigationItem.setRightBarButton(addButtonItem(), animated: true)
  }
  
  func fetchData() {
    userList = CoreDataHelper.sharedInstance.fetchUserArray(withPredicate: nil)!
  }
  
  func addButtonItem() -> UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
  }
  
  func addNewUser() {
  
    let alert = UIAlertController(title: "New entry", message: "User Name.", preferredStyle: UIAlertControllerStyle.alert)
    alert.addTextField { (textfield) in
      let text = textfield.text
      dump(text)
    }
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (alertAction) in
      print("User click Ok button")
//      print(self.textField.text)
      guard let text = alert.textFields?.first?.text else { return }
      self.createUser(withName: text)
    }))
  
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
  }

  func createUser(withName text: String ){
    let user = User.createUserEntity()
    user.createUser(text)
    CoreDataHelper.sharedInstance.saveMainContext()
    fetchData()
    tableView.reloadData()

  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return userList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
    let currentUser = userList[indexPath.row]
    cell.textLabel?.text = currentUser.name

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedUser = userList[indexPath.row]
    userTVCDelegate?.selected(selectedUser)
    self.navigationController?.popViewController(animated: true)
  }
  /*
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the specified item to be editable.
      return true
  }
  */
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCellEditingStyle,
                 forRowAt indexPath: IndexPath)
  {
    let dataToDelete = self.userList[indexPath.row]
    dataToDelete.delete()
    fetchData()
    tableView.reloadData()
  }
}
