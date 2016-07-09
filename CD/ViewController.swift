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

    @IBAction func submitButton(sender: UIButton) {
        let mobile = Mobile.createMobileEntity()
        mobile.createMobile(Int(self.snTextfield.text!)!, name: self.nameTextfield.text!, price: self.priceTextfield.text!)
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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("mobileCell") as? MobileCell else { return UITableViewCell() }
        cell.sn.text = String(self.mobile[indexPath.row].sn!)
        cell.name.text = self.mobile[indexPath.row].name
        cell.price.text = self.mobile[indexPath.row].price
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mobile.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

