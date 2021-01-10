//
//  GameController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit
import Alamofire

struct  commentaire :Decodable {
    
    let idComment:Int
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
    var rate : Int = 0
    
    
    
    
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
    
    @IBOutlet weak var starOne: UIImageView!
    
    @IBOutlet weak var starTwo: UIImageView!
    
    @IBOutlet weak var starThree: UIImageView!
    
    
    @IBOutlet weak var starFour: UIImageView!
    
    
    @IBOutlet weak var starFive: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource=self
        if #available(iOS 13.0, *) {
            gameInformations(idGame: idGame)
        } else {
            // Fallback on earlier versions
        }
        GetComments(idGame: idGame)
        
        getCommentsNbr(idGame: idGame) { (nbr,error) in
            if let x = nbr {
                self.commentNbr.text="\(x)"
                
            }
        }
        
        getFavNbr(idGame: idGame) { (nbr,error) in
            if let x = nbr {
                self.favNbr.text="\(x)"
                
            }
        }
    }
    
    //Functions
    
    func getFavNbr(idGame:Int,completionHandler: @escaping (String?,Error?)->
    Void) {
    let url=URL(string: "http://192.168.64.1:3000/GetFavoriteNbr/"+"\(idGame)")!
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
    
    func getCommentsNbr(idGame:Int,completionHandler: @escaping (String?,Error?)->
    Void) {
    let url=URL(string: "http://192.168.64.1:3000/GetCommentNbr/"+"\(idGame)")!
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
     cell.userPic.downloaded(from: defaultLink)
        
      
        cell.likeComment.addTarget(self, action: #selector(GameController.likeAComment(_:)), for:.touchUpInside)
        cell.likeComment.tag = comments[indexPath.row].idComment
        return cell
    }
    
    @objc func likeAComment(_ sender: UIButton) {
       
        let id = sender.tag
        
        let params = ["idComment":id] as [String : Any]
       // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/LikeComment")!)
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/LikeComment")!)
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
           
                self.viewDidLoad()
            }
            })
            task.resume()
            
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
    
    @available(iOS 13.0, *)
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
        self.rate = json["rating"] as! Int
     
        
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
            if(self.rate==5)
            {
               
                self.starOne.image=UIImage(systemName:"star.fill")
               
                self.starTwo.image=UIImage(systemName:"star.fill")
                self.starThree.image=UIImage(systemName:"star.fill")
                self.starFour.image=UIImage(systemName:"star.fill")
                self.starFive.image=UIImage(systemName:"star.fill")
            }
            else if (self.rate==4) {
                self.starOne.image=UIImage(systemName:"star.fill")
                self.starTwo.image=UIImage(systemName:"star.fill")
                self.starThree.image=UIImage(systemName:"star.fill")
                self.starFour.image=UIImage(systemName:"star.fill")
            }
            else if (self.rate==3) {
                self.starOne.image=UIImage(systemName:"star.fill")
                self.starTwo.image=UIImage(systemName:"star.fill")
                self.starThree.image=UIImage(systemName:"star.fill")
            }
            else if (self.rate==2) {
                self.starOne.image=UIImage(systemName:"star.fill")
                self.starTwo.image=UIImage(systemName:"star.fill")
              
            }
            else if (self.rate==1)
            {
                self.starOne.image=UIImage(systemName:"star.fill")
               
            }
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
    func ExisteGameList(idUser: Int,idGame: Int) {
 
        let url=URL(string: "http://192.168.64.1:3000/VerifyGamelist/"+"\(idUser)"+"/"+"\(idGame)")!
        //let url=URL(string:"http://192.168.247.1:3000/VerifyGamelist/"+"\(idUser)"+"/"+"\(idGame)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
        do {
            let responseData = String(data: data, encoding: String.Encoding.utf8)
        let res = responseData!.replacingOccurrences(of: "\"", with: "")
            if(res.caseInsensitiveCompare("true") == .orderedSame ) {
                DispatchQueue.main.async {
                  
                    self.alert(message: "You added this game already !",title: "Message")
                }
                
            }
            else {
                let params = ["idUser":idUser, "idGame":idGame] as Dictionary<String, Any>
                   // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddToGameList")!)
                    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddToGameList")!)
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
                            self.alert(message: "Game added !",title: "Message")
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
    
    //IBActions
    func ExisteFavList(idUser: Int,idGame: Int) {
 
        let url=URL(string: "http://192.168.64.1:3000/VerifyFavlist/"+"\(idUser)"+"/"+"\(idGame)")!
        //let url=URL(string:"http://192.168.247.1:3000/VerifyFavlist/"+"\(idUser)"+"/"+"\(idGame)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
        do {
            let responseData = String(data: data, encoding: String.Encoding.utf8)
        let res = responseData!.replacingOccurrences(of: "\"", with: "")
            if(res.caseInsensitiveCompare("true") == .orderedSame ) {
                DispatchQueue.main.async {
                  
                    self.alert(message: "You added this game already !",title: "Message")
                }
                
            }
            else {
                let params = ["idUser":idUser, "idGame":idGame] as Dictionary<String, Any>
                   // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddToFavList")!)
                    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddToFavList")!)
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
                            self.alert(message: "Game added !",title: "Message")
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
    
    //IBActions
    func ExisteWishList(idUser: Int,idGame: Int) {
 
        let url=URL(string: "http://192.168.64.1:3000/VerifyWishlist/"+"\(idUser)"+"/"+"\(idGame)")!
        //let url=URL(string:"http://192.168.247.1:3000/VerifyWishlist/"+"\(idUser)"+"/"+"\(idGame)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
        do {
            let responseData = String(data: data, encoding: String.Encoding.utf8)
        let res = responseData!.replacingOccurrences(of: "\"", with: "")
            if(res.caseInsensitiveCompare("true") == .orderedSame ) {
                DispatchQueue.main.async {
                  
                    self.alert(message: "You added this game already !",title: "Message")
                }
                
            }
            else {
                let params = ["idUser":idUser, "idGame":idGame] as Dictionary<String, Any>
                   // var request = URLRequest(url: URL(string: "http://192.168.247.1:3000/AddToWishList")!)
                    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/AddToWishList")!)
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
                            self.alert(message: "Game added !",title: "Message")
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
    
    @IBAction func addGameAction(_ sender: Any) {
        
        ExisteGameList(idUser: idUser,idGame: idGame)

    }
    
    func alert(message: String, title: String ) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
           }
    
    @IBAction func addFavGameAction(_ sender: Any) {
        ExisteFavList(idUser: idUser,idGame: idGame)

        
    }
    
    @IBAction func addWishlistAction(_ sender: Any) {
        
        ExisteWishList(idUser: idUser,idGame: idGame)
        
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
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    }
                    catch {
                }
            DispatchQueue.main.async {
           
                self.viewDidLoad()
            }
            })
            task.resume()
    }
}

