//
//  TableViewCell.swift
//  Real
//
//  Created by MacBook Air on 09.06.2020.
//  Copyright © 2020 VardanMakhsudyan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var realImage: UIImageView!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var realNumber: UILabel!
    @IBOutlet weak var realCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
