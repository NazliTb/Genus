//
//  designedMessageController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/17/20.
//

import UIKit
import SwiftWebSocket




class designedMessageController: UITableViewController {
    
    var idChat:Int=0
    var msg = [Msg]()
    var id:Int=0
    var username:String=""
    var userPicture:String=""
   
    fileprivate let cellId="messagesCell"

    var socket : WebSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = WebSocket("ws://192.168.64.1:3001")
        //socket = WebSocket("ws://192.168.247.1:3001")
        socket.event.open = {
            print("opened")
        }
         
        socket.event.close = { code, reason, clean in
            print("closed")
        }
         
        socket.event.error = { error in
            print("error \(error)")
        }
         
        socket.event.message = { message in
            if let text = message as? String {
                self.handleMessage(jsonString:text)
            }
        }
        socket.open()
        
        getMessages(idChat: idChat)
        
        tableView.register(designedMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    
    }

    func handleMessage(jsonString:String){
        if let data = jsonString.data(using:String.Encoding.utf8){
            do {
                let JSON : [String:AnyObject] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                print("We've successfully parsed the message into a Dictionary! Yay!\n\(JSON)")
                let sender : String = JSON["name"] as! String
                let message : String = JSON["message"] as! String
                let time : String = JSON["time"] as! String
                let pic : String = JSON["pic"] as! String
                let id: Int = JSON["id"] as! Int
                let m = Msg (idMessage: 1, contentMsg: message, date: time, idUser: id, idChat: idChat, username: sender, userPicture: pic)
              
                msg.append(m)
                tableView.reloadData()
                
                
                
            } catch let error{
                print("Error parsing json: \(error)")
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msg.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for : indexPath) as!
        designedMessageCell
 
        cell.messageLabel.text=msg[indexPath.row].contentMsg
        if(msg[indexPath.row].idUser==id) {
        cell.isIncoming = true
            cell.leadingConstraint.isActive=true
            cell.trailingConstraint.isActive=false
        }
        else {
        cell.isIncoming = false
            cell.leadingConstraint.isActive=false
            cell.trailingConstraint.isActive=true
        }

      /*  let str=msg[indexPath.row].date
        cell.timeMSG.text=str
        cell.userName.text=msg[indexPath.row].username*/
        
    
        let defaultLink = "http://192.168.64.1:3000/image/"+msg[indexPath.row].userPicture
        cell.userPic.downloaded(from: defaultLink)
        return cell
    }
    
    func getMessages(idChat:Int)
    {
        var id="\(idChat)"
        let url=URL(string: "http://192.168.64.1:3000/ListMessages/"+id)
            
        // let url = URL(string: "http://192.168.247.1:3000/ListMessages/"+id)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
                if (error==nil) {
                do {
                self.msg = try JSONDecoder().decode([Msg].self, from: data!)
                   
                }
                catch {
                print("ERROR")
                }
                
                DispatchQueue.main.async {
                  
                    self.tableView.reloadData()
                   
                }
            }
                
            }.resume()
    }

}
