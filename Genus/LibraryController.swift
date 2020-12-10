//
//  LibraryController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//


import UIKit

struct GameList :Decodable{
    let idGame : Int
    let name : String
    let companyName : String
    let description : String
    let releaseDate: String
    let gamePicture: String
    let rating: String
    let type: String
    let idGameList: Int
    let idUser: Int
}

struct FavGame :Decodable{
    let idGame : Int
    let name : String
    let companyName : String
    let description : String
    let releaseDate: String
    let gamePicture: String
    let rating: String
    let type: String
    let idFav: Int
    let idUser: Int
}





class LibraryController: UIViewController ,UICollectionViewDataSource{
    
    
    //Var 
    var id:Int=0
  
    
    //Widgets
 
    var games=[GameList]()
    var Favgames=[FavGame]()
    
    @IBOutlet weak var collectionViewGame: UICollectionView!
    @IBOutlet weak var collectionViewFavGame: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewGame.dataSource=self
        collectionViewFavGame.dataSource=self
        GetGameDetails(idUser:"\(id)")
        GetFavList(idUser:"\(id)")
    }

    
    //Functions
    
    func collectionViewGame(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games.count
    }
    
    func collectionViewGame(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionViewGame.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GamesCollectionViewCell
        cell..text=chats[indexPath.row].
        cell..text=chats[indexPath.row].
        cell..text=chats[indexPath.row].
        
        return cell
    }
    
    
    
    func collectionViewFavGame(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Favgames.count
    }
    
    func collectionViewFavGame(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "favgameCell", for: indexPath) as! TopicsCollectionViewCell
        cell..text=chats[indexPath.row].
        cell..text=chats[indexPath.row].
        cell..text=chats[indexPath.row].
        
        return cell
    }
    
    
    func GetGameDetails(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetGameDetails"+idUser)
    // let url = URL(string: "http://192.168.247.1:3000/GetGameDetails"+idUser)
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
    }
    
    
    
    
    
    
    
    func GetFavList(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetFavList"+idUser)!

    }
    

    //IBActions
    
   
    @IBAction func searchAction(_ sender: Any) {
    }
}
