//
//  MessagesController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/16/20.
//

import UIKit
import MessageKit


struct Sender: SenderType {
    
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}




class MessagesController : MessagesViewController,MessagesDataSource ,MessagesLayoutDelegate,MessagesDisplayDelegate, UITableViewDelegate, UITableViewDataSource{
   
    
    
    let currentUser = Sender (senderId: "2", displayName: "Sihem")
    let otherUser = Sender (senderId: "3", displayName: "Senjiro")
    var messages = [MessageType]()
    
    @IBOutlet weak var messagesTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.register(UITableViewCell.self, forCellReuseIdentifier: "messagesCell")
        messagesTable.delegate=self
        messagesTable.dataSource=self
        messages.append(Message(sender: currentUser,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .text("hey")))
        messages.append(Message(sender: otherUser,
                                messageId: "2",
                                sentDate: Date(),
                                kind: .text("hello")))
        messagesCollectionView.messagesDataSource=self
        messagesCollectionView.messagesLayoutDelegate=self
        messagesCollectionView.messagesDisplayDelegate=self
    }
    
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.row]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTable.dequeueReusableCell(withIdentifier: "messagesCell",for : indexPath)
        return cell
    }
}
