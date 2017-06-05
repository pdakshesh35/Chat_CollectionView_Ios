//
//  TableViewCell.swift
//  tableView
//
//  Created by Dakshesh patel on 4/8/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatView.layer.masksToBounds = true;
        chatView.layer.cornerRadius = 10;
        
        img.layer.masksToBounds = true;
        img.layer.cornerRadius = img.frame.size.height/2;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
