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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionViewGame) {
            return games.count
            
        }
        else {
            return Favgames.count }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.collectionViewGame) {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "GameListCell", for: indexPath) as! GameListCollectionViewCell
        cell.companyName.text=games[indexPath.row].companyName
        cell.gameName.text=games[indexPath.row].name
        cell.gameType.text=games[indexPath.row].type
       // cell.gameImage.text=games[indexPath.row].gamePicture
        cell.releaseDate.text=games[indexPath.row].releaseDate
            return cell
        }
        else {
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "FavGameCell", for: indexPath) as! FavGameCollectionViewCell
            
            cell.companyName.text=Favgames[indexPath.row].companyName
            cell.gameName.text=Favgames[indexPath.row].name
            cell.gameType.text=Favgames[indexPath.row].type
           // cell.gameImage.text=Favgames[indexPath.row].gamePicture
            cell.releaseDate.text=Favgames[indexPath.row].releaseDate
            return cell
        }
        
    }
    


    
    
    func GetGameDetails(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetGameDetails"+idUser)
    // let url = URL(string: "http://192.168.247.1:3000/GetGameDetails"+idUser)
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
            if (error==nil) {
            do {
            self.games = try JSONDecoder().decode([GameList].self, from: data!)
               
            }
            catch {
            print("ERROR")
            }
            
            DispatchQueue.main.async {
              
                self.collectionViewGame.reloadData()
            }
        }
            
        }.resume()
        }
    
    
    
    
    
    
    
    
    func GetFavList(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetFavList"+idUser)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
                if (error==nil) {
                do {
                self.Favgames = try JSONDecoder().decode([FavGame].self, from: data!)
                   
                }
                catch {
                print("ERROR")
                }
                
                DispatchQueue.main.async {
                  
                    self.collectionViewFavGame.reloadData()
                }
            }
                
            }.resume()
    }
    

    //IBActions
    
   
    @IBAction func searchAction(_ sender: Any) {
    }
}
