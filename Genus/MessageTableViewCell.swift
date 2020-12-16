//
//  MessageTableViewCell.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/16/20.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var timeMSG: UITextView!
    
    @IBOutlet weak var userPic: UIImageView!
    

    @IBOutlet weak var msgContent: UITextView!
    
    
    
    @IBOutlet weak var userName: UITextView!
    
}
