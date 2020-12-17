//
//  designedMessageCell.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/17/20.
//

import UIKit

class designedMessageCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userPicture: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var userMsg: UILabel!
    
    let messageLabel = UILabel()
    let userPic : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let bubbleBackgroundView = UIView()
        
    
    
    var leadingConstraint : NSLayoutConstraint!
    var trailingConstraint : NSLayoutConstraint!
    
    var leadingConstraintPic : NSLayoutConstraint!
    var trailingConstraintPic : NSLayoutConstraint!
    
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
        addSubview(userPic)
        
       
       
        
        messageLabel.translatesAutoresizingMaskIntoConstraints=false
        userPic.translatesAutoresizingMaskIntoConstraints=false
        messageLabel.numberOfLines = 0
       let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor,constant: 32),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -32),
       
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor,constant: -16),
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor,constant: -16),
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor,constant: 16),
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor,constant: 16),
        userPic.widthAnchor.constraint(equalToConstant: 50),
        userPic.heightAnchor.constraint(equalToConstant: 50),
        userPic.topAnchor.constraint(equalTo: bubbleBackgroundView.topAnchor,constant: -50),
        
        
       
       
       ]
        
        NSLayoutConstraint.activate(constraints)
      
       leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 32)
        
        leadingConstraintPic = userPic.leadingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor,constant: 0)
       leadingConstraint.isActive=false
       leadingConstraintPic.isActive=false
        
       trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -32)
        trailingConstraintPic = userPic.trailingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor,constant: 0)
       trailingConstraint.isActive=true
       trailingConstraintPic.isActive=true
        
    }
    
    
  
    
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
