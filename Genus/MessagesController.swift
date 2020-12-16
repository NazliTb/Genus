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
    
    //Widgets
    
    @IBOutlet weak var messagesTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.delegate=self
        messagesTable.dataSource=self
        getMessages(idChat: idChat)
       
    }
    
    //Functions
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTable.dequeueReusableCell(withIdentifier: "messagesCell",for : indexPath)
        
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
                  
                    self.messagesTable.reloadData()
                }
            }
                
            }.resume()
    }
}
