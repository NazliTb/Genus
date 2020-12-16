//
//  ChatController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/8/20.
//

import UIKit

struct Chat :Decodable{
    let idChat : Int
    let topic : String
    let Date : String
    let username : String
}

class ChatController: UIViewController,UICollectionViewDataSource{
    

    //Widgets
    
    var chats=[Chat]()
    var idChat:Int=0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        collectionView.dataSource=self
        GetChatList()

    }

    //Functions
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! TopicsCollectionViewCell
        cell.topicName.text=chats[indexPath.row].topic
        cell.dateTopic.text=chats[indexPath.row].Date
        cell.topicCreator.text=chats[indexPath.row].username
        idChat=chats[indexPath.row].idChat
        cell.joinTopic.addTarget(self, action: #selector(buttonClicked),  for: .touchUpInside)
        cell.joinTopic.tag = indexPath.row
        
        return cell
    }

    @objc func buttonClicked(sender:UIButton!) {
           
        let vc = MessagesController()
        print(idChat)
        vc.idChat = idChat
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    
    
        }
    
    func GetChatList() {
    let url=URL(string: "http://192.168.64.1:3000/GetChatList")
    // let url = URL(string: "http://192.168.247.1:3000/GetChatList"))
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
    
        if (error==nil) {
        do {
        self.chats = try JSONDecoder().decode([Chat].self, from: data!)
           
        }
        catch {
        print("ERROR")
        }
        
        DispatchQueue.main.async {
          
            self.collectionView.reloadData()
        }
    }
        
    }.resume()
    }

    //IBActions
    
   
    @IBAction func searchAction(_ sender: Any) {
    }
}
