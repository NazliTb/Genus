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

class ChatController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{
    

    //Widgets
    
    var chats=[Chat]()
    var id:Int=0
    var userPicture:String=""
    var username:String=""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        collectionView.dataSource=self
        collectionView.delegate = self
        collectionView.allowsSelection = true
       

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
        
        
        
        getMembersNbr(idChat: chats[indexPath.row].idChat) { (nbr,error) in
            if let x = nbr {
                cell.memberNumbers.text="Members : "+"\(x)"
                
            }
        }
        
        
        
        cell.joinTopic.addTarget(self, action: #selector(ChatController.joinThatTopic(_:)), for:.touchUpInside)
        cell.joinTopic.tag = chats[indexPath.row].idChat
        return cell
    }

    
    func getMembersNbr(idChat:Int,completionHandler: @escaping (String?,Error?)->
    Void) {
    let url=URL(string: "http://192.168.64.1:3000/GetMembersNbr/"+"\(idChat)")!
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let responseData = String(data: data, encoding: String.Encoding.utf8)
    let res = responseData!.replacingOccurrences(of: "\"", with: "")
    completionHandler(res,nil)
    }
    catch let parseErr {
    print(parseErr)
    
    }
    })
    task.resume()
    }
 
    @objc func joinThatTopic(_ sender: UIButton) {
       
        let idTopic = sender.tag
        let url=URL(string: "http://192.168.64.1:3000/verifyParticipation/"+"\(id)"+"/"+"\(idTopic)")!
        //let url=URL(string:"http://192.168.247.1:3000/verifyParticipation/"+"\(id)"+"/"+"\(idTopic)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
        do {
            let responseData = String(data: data, encoding: String.Encoding.utf8)
        let res = responseData!.replacingOccurrences(of: "\"", with: "")
            if(res.caseInsensitiveCompare("true") == .orderedSame ) {
                DispatchQueue.main.async {
                  
                    print("User is participating already")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagesController")as! MessagesController
                      vc.idChat=idTopic
                    vc.id=self.id
                    vc.username=self.username
                    vc.userPicture=self.userPicture
                       self.navigationController?.pushViewController(vc, animated: true)
                   
                }
                
            }
            else {
                let params = ["idUser":self.id, "idChat":idTopic] as Dictionary<String, Any>
                   // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/addParticipation")!)
                    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/addParticipation")!)
                    request.httpMethod = "POST"
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    let session = URLSession.shared
                    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                            do {
                                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                                }
                                catch {
                            }
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Message", message: "Welcome to the party", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default)
                            { action -> Void in
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagesController")as! MessagesController
                                self.collectionView.reloadData()
                                  vc.idChat=idTopic
                                vc.id=self.id
                                vc.username=self.username
                                vc.userPicture=self.userPicture
                                   self.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                            alertController.addAction(OKAction)
                            self.present(alertController, animated: true, completion: nil)
                           
                            
                        }
                        })
                        task.resume()
            }
        }
        catch let parseErr {
        print(parseErr)
         
        }
        })
        task.resume()
        
    }
    
    
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessagesController")as! MessagesController
        vc.idChat=chats[indexPath.row].idChat
              vc.id=id
        vc.username=username
        vc.userPicture=userPicture
         self.navigationController?.pushViewController(vc, animated: true)
        
    }*/
    
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
