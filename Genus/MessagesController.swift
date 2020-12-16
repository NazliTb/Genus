//
//  MessagesController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/16/20.
//

import UIKit


struct Msg :Decodable{
    let idMessage : Int
    let contentMsg : String
    let date : String
    let idUser : Int
    let idChat : Int
    let username : String
    let userPicture : String
   
}



class MessagesController : UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    //var
    
    var idChat:Int=0
    var msg=[Msg]()
    var id:Int=0
    
    //Widgets

    
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    
    @IBOutlet weak var msgToSend: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.dataSource=self
        messagesTableView.delegate=self
     
        getMessages(idChat: idChat)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewDidLoad()
            messagesTableView.dataSource=self
            messagesTableView.delegate=self
         
            getMessages(idChat: idChat)
        }
        
    
    //Functions
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msg.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "messagesCell",for : indexPath) as! MessageTableViewCell
        cell.msgContent.text=msg[indexPath.row].contentMsg
        print(msg[indexPath.row].date)
        cell.timeMSG.text=msg[indexPath.row].date
        cell.userName.text=msg[indexPath.row].username
        cell.userPic.contentMode = .scaleAspectFill
    
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
                  
                    self.messagesTableView.reloadData()
                    self.viewWillAppear(true)
                }
            }
                
            }.resume()
    }
    
    
    
    
    @IBAction func sendMsg(_ sender: Any) {
        let msg=msgToSend.text
        let params = ["idUser":"\(id)", "contentMsg":msg,"idChat":"\(idChat)"] as! Dictionary<String, String>
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/addMsg")!)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
    
        
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
      
                
                }
                catch {
                    self.messagesTableView.reloadData()
            }
       
       
    
        
        DispatchQueue.main.async {
           
    
        }
        
        })
        
     
        task.resume()
    
    
    }
    }
    

