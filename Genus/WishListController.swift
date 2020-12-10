//
//  WishListController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/8/20.
//

import UIKit

struct wishGame :Decodable{
    let idGame:Int
    let name:String
    let companyName:String
    let releaseDate:String
    let gamePicture:String
    let type:String
   
}

class WishListController: UIViewController, UICollectionViewDataSource {
    
    //Widgets
    
    //Var
    var id:Int=0
    var games=[wishGame]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        collectionView.dataSource=self
        GetWishList(idUser:"\(id)")
    }
    
    //functions
       
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "wishlistCell", for: indexPath) as! WishlistCollectionViewCell
        cell.name.text=games[indexPath.row].name
        cell.companyName.text=games[indexPath.row].companyName
        cell.type.text=games[indexPath.row].type
        cell.releaseDate.text=games[indexPath.row].releaseDate
                
        return cell
    }
             
    
    func GetWishList(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetWishListIOS/"+idUser)
        print(url)
     //let url = URL(string: "http://192.168.247.1:3000/GetWishList"+idUser)
        print(url)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if (error==nil) {
            do {
            self.games=try JSONDecoder().decode([wishGame].self, from: data!)
               
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
