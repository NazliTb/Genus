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
    let description:String
    let releaseDate:Date
    let gamePicture:String
    let rating:Int
    let type:String
    let idWishList:Int
    let idUser:Int
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
        GetWishList(idUser: <#T##String#>)

    }
    
    //functions
       
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        games.count
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "wishlistCell", for: indexPath) as! WishlistCollectionViewCell
        cell.gameName.text=games[indexPath.row].name
        cell.studioName.text=games[indexPath.row].companyName
        
        return cell
            <#code#>
    }
             
    
    func GetWishList(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetWishList"+idUser)!
    // let url = URL(string: "http://192.168.247.1:3000/GetWishList"+idUser)!)
    
   
        //Naz nrmlnt houni tged mtaa collectionView
   
    }    
    

    //IBActions
    
   
    @IBAction func searchAction(_ sender: Any) {
    }
}
