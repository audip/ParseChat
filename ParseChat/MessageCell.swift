//
//  MessageCell.swift
//  ParseChat
//
//  Created by Aditya Purandare on 18/02/16.
//  Copyright © 2016 Aditya Purandare. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
