//
//  MobileCell.swift
//  CD
//
//  Created by Sanjay Maharjan on 7/9/16.
//  Copyright © 2016 Sanjay Maharjan. All rights reserved.
//

import UIKit

class MobileCell: UITableViewCell {

  @IBOutlet var sn: UILabel!
  @IBOutlet var name: UILabel!
  @IBOutlet var price: UILabel!
  @IBOutlet weak var user: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
