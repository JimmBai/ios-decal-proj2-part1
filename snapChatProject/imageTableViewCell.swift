//
//  imageTableViewCell.swift
//  snapChatProject
//
//  Created by Jim Bai on 2017/3/14.
//  Copyright © 2017年 org.iosdecal. All rights reserved.
//

import UIKit

class imageTableViewCell: UITableViewCell {

    @IBOutlet var readBit: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var postTime: UILabel!
    var imageLink:UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
