//
//  designedMessageCell.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/17/20.
//

import UIKit

class designedMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var isIncoming : Bool! {
        didSet {
            bubbleBackgroundView.backgroundColor = isIncoming ? UIColor.init(hexString: "#04D9D9") : UIColor.init(hexString: "#111C59")
            messageLabel.textColor = isIncoming ? .black : .white
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        
        bubbleBackgroundView.backgroundColor = .cyan
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.layer.cornerRadius = 12
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
       
       
        
        messageLabel.translatesAutoresizingMaskIntoConstraints=false
        messageLabel.numberOfLines = 0
       let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor,constant: 32),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -32),
       // messageLabel.widthAnchor.constraint(equalToConstant: 250),
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor,constant: -16),
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor,constant: -16),
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor,constant: 16),
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor,constant: 16)
       
       
       ]
        
        NSLayoutConstraint.activate(constraints)
      
       let leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 32)
       leadingConstraint.isActive=false
        let trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -32)
       trailingConstraint.isActive=true
    }
    
    
    //var leadingConstraint = 
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
