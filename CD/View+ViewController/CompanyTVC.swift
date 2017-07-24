//
//  CompanyTVC.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/24/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//
//
//  UserTVC.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/21/17.
//  Copyright © 2017 Sanjay Maharjan. All rights reserved.
//

import UIKit
protocol CompanyTVCDelegate: class {
  func selectedCompany(_ selected: Company)
}

class CompanyTVC: UITableViewController {
  var companyList = [Company]()
  var additionAlert: UIAlertController!
  
  var companyTVCDelegate: CompanyTVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
    title = "Company List"
    self.navigationItem.setRightBarButton(addButtonItem(), animated: true)
  }
  
  func fetchData() {
    companyList = CoreDataHelper.sharedInstance.fetchCompanyArray(withPredicate: nil)!
  }
  
  func addButtonItem() -> UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCompany))
  }
  
  func addNewCompany() {
    
    let alert = UIAlertController(title: "New entry", message: "Company Name.", preferredStyle: UIAlertControllerStyle.alert)
    alert.addTextField { (textfield) in
      let text = textfield.text
      dump(text)
    }
    
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (alertAction) in
      print("Company click Ok button")
      //      print(self.textField.text)
      guard let text = alert.textFields?.first?.text else { return }
      self.createCompany(withName: text)
    }))
    
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
  }
  
  func createCompany(withName text: String ){
    let user = Company.createCompanyEntity()
    user.createCompany(text)
    CoreDataHelper.sharedInstance.saveMainContext()
    fetchData()
    tableView.reloadData()
    
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return companyList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
    let currentCompany = companyList[indexPath.row]
    cell.textLabel?.text = currentCompany.name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCompany = companyList[indexPath.row]
    companyTVCDelegate?.selectedCompany(selectedCompany)
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
    let dataToDelete = self.companyList[indexPath.row]
    dataToDelete.delete()
    fetchData()
    tableView.reloadData()
  }
}
