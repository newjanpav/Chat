//
//  MessageCellTableViewCell.swift
//  Chat
//
//  Created by Pavel Shymanski on 22.05.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var imageMessage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
