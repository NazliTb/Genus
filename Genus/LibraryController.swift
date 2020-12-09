//
//  LibraryController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//


import UIKit



class LibraryController: UIViewController {
    
    
    //Var 
    var id:Int=0
  
    
    //Widgets
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //Functions
    
    func GetFavList(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetFavList"+idUser)!
    // let url = URL(string: "http://192.168.247.1:3000/GetFavList"+idUser)!)
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
    let idGame = json["idGame"] as! Int
    let name=json["name"] as! String
    let comanyName=json["companyName"] as! String
    let description=json["description"] as! String
    let releaseDate=json["releaseDate"] as! String
    let gamePicture=json["gamePicture"] as! String
    let rating=json["rating"] as! String
    let type=json["type"] as! String
   
        //Naz nrmlnt houni tged mtaa collectionView
   
    }
    catch let parseErr {
    print(parseErr)
    
    }
    })
    task.resume()
    }
    
    
    
    func GetGameDetails(idUser:String) {
    let url=URL(string: "http://192.168.64.1:3000/GetGameDetails"+idUser)!
    // let url = URL(string: "http://192.168.247.1:3000/GetGameDetails"+idUser)!)
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
    let idGame = json["idGame"] as! Int
    let name=json["name"] as! String
    let comanyName=json["companyName"] as! String
    let description=json["description"] as! String
    let releaseDate=json["releaseDate"] as! String
    let gamePicture=json["gamePicture"] as! String
    let rating=json["rating"] as! String
    let type=json["type"] as! String
   
        //Naz nrmlnt houni tged mtaa collectionView
   
    }
    catch let parseErr {
    print(parseErr)
    
    }
    })
    task.resume()
    }
    
    
    
    
    
    
    
    
    
    

    //IBActions
    
   
    @IBAction func searchAction(_ sender: Any) {
    }
}
