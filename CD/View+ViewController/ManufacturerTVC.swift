//
//  ManufacturerTVC.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import UIKit
protocol ManufacturerTVCDelegate {
  func selected(_ selected: Manufacturer)
}

class ManufacturerTVC: UITableViewController {
  var manufacturerList = [Manufacturer]()
  var additionAlert: UIAlertController!
  
  var manufacturerTVCDelegate: ManufacturerTVCDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
    self.navigationItem.setRightBarButton(addButtonItem(), animated: true)
  }
  
  func fetchData() {
    manufacturerList = CoreDataHelper.sharedInstance.fetchManufacturerArray(withPredicate: nil)!
  }
  
  func addButtonItem() -> UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewManufacturer))
  }
  
  func addNewManufacturer() {
  
    let alert = UIAlertController(title: "New entry", message: "Manufacturer Name.", preferredStyle: UIAlertControllerStyle.alert)
    alert.addTextField { (textfield) in
      let text = textfield.text
      dump(text)
    }
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (alertAction) in
      print("User click Ok button")
//      print(self.textField.text)
      guard let text = alert.textFields?.first?.text else { return }
      self.createManufacturer(withName: text)
    }))
  
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
  }

  func createManufacturer(withName text: String ){
    var manufacturer = Manufacturer.createManufacturerEntity()
    manufacturer.createManufacturer(text)
    CoreDataHelper.sharedInstance.saveMainContext()
    fetchData()
    tableView.reloadData()

  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return manufacturerList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
    let currentManufacturer = manufacturerList[indexPath.row]
    cell.textLabel?.text = currentManufacturer.name

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedManufacturer = manufacturerList[indexPath.row]
    manufacturerTVCDelegate?.selected(selectedManufacturer)
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
    let dataToDelete = self.manufacturerList[indexPath.row]
    dataToDelete.delete()
    fetchData()
    tableView.reloadData()
  }
}
