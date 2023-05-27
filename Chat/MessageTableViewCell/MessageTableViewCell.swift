//
//  MessageTableViewCell.swift
//  Chat
//
//  Created by Pavel Shymanski on 27.05.23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var avatarOne: UIImageView!
    @IBOutlet weak var avatarTwo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textMessage.layer.cornerRadius = textMessage.frame.height / 4
        textMessage.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

