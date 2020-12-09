//
//  ChatController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/8/20.
//

import UIKit

class ChatController: UIViewController {
    
    //Widgets
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Functions
    func GetChatList() {
    let url=URL(string: "http://192.168.64.1:3000/GetChatList")!
    // let url = URL(string: "http://192.168.247.1:3000/GetChatList")!)
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
    let idChat = json["idChat"] as! Int
    let topic=json["topic"] as! String
    let Date=json["Date"] as! String
    let user=json["username"] as! String
    
   
        
   
    }
    catch let parseErr {
    print(parseErr)
    
    }
    })
    task.resume()
    }

    //IBActions
    
   
    @IBAction func searchAction(_ sender: Any) {
    }
}
