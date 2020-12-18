//
//  GameController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit

struct commentList :Decodable{
    let commentText:String
    let likesNbr:Int
    let userPicture:String
    let userName:String
}

class GameController: UIViewController, UICollectionViewDataSource {
        
  //var
    var idGame:Int=0
    var idUser:Int=0
    var comments=[commentList]()
    
    var gamePicture :  String = ""
    var gamename :  String = ""
    var gamestudio : String = ""
    var gameDesc : String = ""
    
    
    
    //Widgets
   
    @IBOutlet weak var gamePic: UIImageView!
    @IBOutlet weak var gameBg: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameStudio: UILabel!
    @IBOutlet weak var favNbr: UILabel!
    @IBOutlet weak var commentNbr: UILabel!
    @IBOutlet weak var gameDescription: UITextView!
    @IBOutlet weak var addGamelist: UIButton!
    @IBOutlet weak var addFavlist: UIButton!
    @IBOutlet weak var addWishlist: UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var sencCmnt: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource=self
        gameInformations(idGame: idGame)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comments.count
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CommentsCell", for: indexPath) as! CommentCollectionViewCell
        cell.userName.text=comments[indexPath.row].userName
       //cell.commentText.text=comments[indexPath.row].companyName
       // cell.likesNbr.text=comments[indexPath.row].likesNbr
        cell.userPic.contentMode = .scaleAspectFill
        let defaultLink = "http://192.168.64.1:3000/image/"+comments[indexPath.row].userPicture
       // let defaultLink = "http://192.168.247.1:3000/image/"+comments[indexPath.row].userPicture
        cell.userPic.downloaded(from: defaultLink)
        return cell
    }
    
    
    func gameInformations (idGame:Int){

            
        let url=URL(string: "http://192.168.64.1:3000/GetGameDetailsiOS/"+"\(idGame)")
       // let url = URL(string: "http://192.168.247.1:3000/GetGameDetailsiOS/"+"\(idGame)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in            
          
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        print(json)
                        self.gamePicture = json["gamePicture"] as! String
                        self.gamename = json["name"] as! String
                        self.gamestudio = json["companyName"] as! String
                        self.gameDesc = json["description"] as! String
                        
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            
            DispatchQueue.main.async {
              //  let defaultLink = "http://192.168.247.1:3000/image/"+self.gamePicture
                let defaultLink = "http://192.168.64.1:3000/image/"+self.gamePicture
                self.gameBg.downloaded(from: defaultLink)
                self.gamePic.downloaded(from: defaultLink)
                self.gameName.text = self.gamename
                self.gameStudio.text = self.gamestudio
                self.gameDescription.text = self.gameDesc
            }
        
            
        }.resume()
        
    }
    
    func GetComments (idGame:Int){
        
        let url=URL(string: "http://192.168.64.1:3000/GetCommentsiOS/"+"\(idGame)")
       // let url = URL(string: "http://192.168.247.1:3000/GetCommentsiOS/"+"\(idGame)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if (error==nil) {
            do {
            self.comments=try JSONDecoder().decode([commentList].self, from: data!)
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
    
    @IBAction func addGameAction(_ sender: Any) {
    }
    
    
    @IBAction func addFavGameAction(_ sender: Any) {
    }
    
    @IBAction func addWishlistAction(_ sender: Any) {
    }
    
    @IBAction func addCommentAction(_ sender: Any) {
        
        let params = ["commentText":comment.text, "idUser":idUser, "idGame":idGame] as! Dictionary<String, Any>
       // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddComment")!)
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddComment")!)
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
                print("Comment added")
            }
            })
            task.resume()
    }
}

