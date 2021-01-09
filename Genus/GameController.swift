//
//  GameController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit
import Alamofire

struct  commentaire :Decodable {
    
    let commentText:String
    let likesNbr:Int
    let userPicture:String
    let username:String
}

class GameController: UIViewController, UICollectionViewDataSource {
        
  //var
    var idGame:Int = 0
    var idUser:Int = 0
    var comments = [commentaire]()
    
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
        GetComments(idGame: idGame)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comments.count
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentsCell", for: indexPath) as! CommentCollectionViewCell
        cell.userName.text=comments[indexPath.row].username
       cell.commentText.text=comments[indexPath.row].commentText
       cell.likesNbr.text="\(comments[indexPath.row].likesNbr)"
       
        let defaultLink = "http://192.168.64.1:3000/image/"+comments[indexPath.row].userPicture
       // let defaultLink = "http://192.168.247.1:3000/image/"+comments[indexPath.row].userPicture
       // cell.userPic.downloaded(from: defaultLink)
        return cell
    }
    
    func blurBgImage(image: UIImage) -> UIImage? {
            let radius: CGFloat = 20;
            let context = CIContext(options: nil);
            let inputImage = CIImage(cgImage: image.cgImage!);
            let filter = CIFilter(name: "CIGaussianBlur");
 
            filter?.setValue(inputImage, forKey: kCIInputImageKey);
            filter?.setValue("\(radius)", forKey:kCIInputRadiusKey);

            if let result = filter?.value(forKey: kCIOutputImageKey) as? CIImage{

                let rect = CGRect(origin: CGPoint(x: radius * 2,y :radius * 2), size: CGSize(width: image.size.width - radius * 4, height: image.size.height - radius * 4))

                if let cgImage = context.createCGImage(result, from: rect){
                    return UIImage(cgImage: cgImage);
                    }
            }
            return nil;
        }
    
    func gameInformations (idGame:Int){

    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/GetGameDetailsiOS/"+"\(idGame)")!)
    //var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/GetGameDetailsiOS/"+"\(idGame)")!)
            
    request.httpMethod = "GET"


    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in

    do {
               
let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
        self.gamePicture = json["gamePicture"] as! String
        self.gamename = json["name"] as! String
        self.gamestudio = json["companyName"] as! String
        self.gameDesc = json["description"] as! String
                           
    }
   
    catch {
                        
    }
        
        DispatchQueue.main.async {
          //  let defaultLink = "http://192.168.247.1:3000/image/"+self.gamePicture
            let defaultLink = "http://192.168.64.1:3000/image/"+self.gamePicture
            let url = URL(string: "http://192.168.64.1:3000/image/"+self.gamePicture)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            self.gameBg.image = self.blurBgImage(image: image!)
            self.gamePic.downloaded(from: defaultLink)
            self.gameName.text = self.gamename
            self.gameStudio.text = self.gamestudio
            self.gameDescription.text = self.gameDesc
        }
    }
    )
    
    task.resume()
    
  
        
    }
    
    func GetComments (idGame:Int){
        
        let url=URL(string: "http://192.168.64.1:3000/GetCommentsiOS/"+"\(idGame)")
       // let url = URL(string: "http://192.168.247.1:3000/GetCommentsiOS/"+"\(idGame)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
            
            if (error==nil) {
            do {
                self.comments = try JSONDecoder().decode([commentaire].self, from: data!)
        
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
        
        let params = ["idUser":idUser, "idGame":idGame] as Dictionary<String, Any>
       // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddToGameList")!)
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddToGameList")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    _ = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    }
                    catch {
                }
            DispatchQueue.main.async {
                print("Game added to library")
            }
            })
            task.resume()
    }
    
    
    @IBAction func addFavGameAction(_ sender: Any) {
        
        let params = ["idUser":idUser, "idGame":idGame] as Dictionary<String, Any>
       // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddToFavList")!)
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddToFavList")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    _ = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    }
                    catch {
                }
            DispatchQueue.main.async {
                print("Game added to favorites")
            }
            })
            task.resume()
        
    }
    
    @IBAction func addWishlistAction(_ sender: Any) {
        
        let params = ["idUser":idUser, "idGame":idGame] as Dictionary<String, Any>
       // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddToWishList")!)
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddToWishList")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    _ = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    }
                    catch {
                }
            DispatchQueue.main.async {
                print("Game added to wishlist")
            }
            })
            task.resume()
        
    }
    
    @IBAction func addCommentAction(_ sender: Any) {
        
        let params = ["commentText":comment.text!, "idUser":idUser, "idGame":idGame] as [String : Any]
       // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddComment")!)
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddComment")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                do {
                    _ = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
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

