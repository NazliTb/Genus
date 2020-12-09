//
//  DiscoverController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/9/20.
//

import UIKit

class DiscoverController: UIViewController {
    
    //Widgets
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

 
    //Functions
    
    
    func getTopPicks() {
    let url=URL(string: "http://192.168.64.1:3000/GetTopPicksGames")!
    // let url = URL(string: "http://192.168.247.1:3000/GetTopPicksGames")!)
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
    
    
    
    func getTrendingGames() {
    let url=URL(string: "http://192.168.64.1:3000/GetTrendingGames")!
    // let url = URL(string: "http://192.168.247.1:3000/GetTrendingGames")!)
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
        
   
    }
    catch let parseErr {
    print(parseErr)
    
    }
    })
    task.resume()
    }
    
    func getBestRateGames() {
    let url=URL(string: "http://192.168.64.1:3000/GetBestRateGames")!
    // let url = URL(string: "http://192.168.247.1:3000/GetBestRateGames")!)
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
        
   
    }
    catch let parseErr {
    print(parseErr)
    
    }
    })
    task.resume()
    }
    
    
    //IBActions
    
    @IBAction func search(_ sender: Any) {
    }
    
    
}
