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
    
    @IBOutlet var mobileTableView: UITableView!
    
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

    @IBAction func submitButton(_ sender: UIButton) {
        let mobile = Mobile.createMobileEntity()
        mobile.createMobile(self.snTextfield.text!, name: self.nameTextfield.text!, price: self.priceTextfield.text!)
        CoreDataHelper.sharedInstance.saveMainContext()
        fetchData()
        self.mobileTableView.reloadData()
        print("saved")
    }
    
    func fetchData() {
        self.mobile = CoreDataHelper.sharedInstance.fetchMobileArray(withPredicate: nil)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell") as? MobileCell else { return UITableViewCell() }
        cell.sn.text = String(describing: self.mobile[indexPath.row].sn!)
      cell.name.text = String(describing: self.mobile[indexPath.row].name)
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
    
    func deleteData(_ dataToDelete: Mobile) {
      dataToDelete.delete()
        //CoreDataHelper.sharedInstance.managedObjectContext.delete(dataToDelete)
    }
}

