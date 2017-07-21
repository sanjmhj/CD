//
//  ViewController.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/9/16.
//  Copyright © 2016 Sanjay Maharjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  @IBOutlet var snTextfield: UITextField!
  @IBOutlet var nameTextfield: UITextField!
  @IBOutlet var priceTextfield: UITextField!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet var mobileTableView: UITableView!
  
  var selectedUser: User?
    
  var mobile = [Mobile]()
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
    mobileTableView.tableFooterView = UIView()
    mobileTableView.dataSource = self
    mobileTableView.delegate = self
    self.mobileTableView.reloadData()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func manufacturerButton(_ sender: UIButton) {
    //Select manufacturer
    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    let manuTVC = sb.instantiateViewController(withIdentifier: "UserTVC") as! UserTVC
    manuTVC.userTVCDelegate = self
    
    self.navigationController?.pushViewController(manuTVC, animated: true)
  }
  
  @IBAction func submitButton(_ sender: UIButton) {
    guard
    let mobileSN = self.snTextfield.text,
    let mobileName = self.nameTextfield.text,
    let mobilePrice = self.priceTextfield.text,
    let user = self.selectedUser,
    !mobileSN.isEmpty,
    !mobileName.isEmpty,
    !mobilePrice.isEmpty
    
    else { return }
    
    let mobile = Mobile.createMobileEntity()
    mobile.createMobile(mobileSN, name: mobileName, price: mobilePrice, user: user)
    CoreDataHelper.sharedInstance.saveMainContext()
    fetchData()
    self.mobileTableView.reloadData()
//        print("saved")
  }
  
  func fetchData() {
    self.mobile = CoreDataHelper.sharedInstance.fetchMobileArray(withPredicate: nil)!
//    self.userList = CoreDataHelper.sharedInstance.fetchUserArray(withPredicate: nil)!
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell") as? MobileCell else { return UITableViewCell() }
    let mobile = self.mobile[indexPath.row]
    cell.sn.text = String(describing: mobile.sn!)
    cell.name.text = String(describing: mobile.name)
    cell.user.text = String(describing: mobile.user?.name)
    cell.price.text = self.mobile[indexPath.row].price
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.mobile.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath)
  {
    let dataToDelete = self.mobile[indexPath.row]
    deleteData(dataToDelete)
    fetchData()
    tableView.reloadData()
  }
  
  func deleteData(_ dataToDelete: CRUDable) {
    dataToDelete.delete()
      //CoreDataHelper.sharedInstance.managedObjectContext.delete(dataToDelete)
  }

}

extension ViewController: UserTVCDelegate {
  func selected(_ selected: User) {
    self.selectedUser = selected
    self.userLabel.text = selected.name
  }
}

