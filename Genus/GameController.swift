//
//  GameController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit

class GameController: UIViewController {
    
  //var
    var idGame:Int=0
    var idUser:Int=0
    
    
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
    }
    
    func gameInformations (idGame:Int){
        //let url=URL(string: "http://192.168.64.1:3000/GetGameListIOS/"+idUser)
        let url = URL(string: "http://192.168.247.1:3000/GetGameListIOS/"+"\(idUser)")
        
        
    }


    //IBActions
    
    @IBAction func addAction(_ sender: Any) {
    }
    
    
    @IBAction func returnAction(_ sender: Any) {
    }
    
    
    @IBAction func settingAction(_ sender: Any) {
    }
    
    
    
}
