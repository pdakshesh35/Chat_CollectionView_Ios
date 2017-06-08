//
//  TableViewCell.swift
//  tableView
//
//  Created by Dakshesh patel on 4/8/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

 
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bgView: UIView!
    
    var estimatedFrame : CGRect!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        textView.sizeToFit()
         estimatedFrame = NSString(string: textView.text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 18.0)], context: nil)
        textView.frame = CGRect(x: 0, y: 0, width: 250 + 16, height: estimatedFrame.height + 20)
        bgView.frame = CGRect(x: 0, y: 0, width: 250 + 16, height: estimatedFrame.height + 20)
        
        print(estimatedFrame.height)
        
        textView.font = UIFont.systemFont(ofSize: 18.0)
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
