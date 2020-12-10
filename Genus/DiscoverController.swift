//
//  DiscoverController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/9/20.
//

import UIKit

struct TopPicks {
    let idGame:Int
    let name:String
    let companyName:String
    let description:String
    let releaseDate:Date
    let gamePicture:String
    let rating:Int
    let type:String
}

struct TrendingGames {
    let idGame:Int
    let name:String
    let companyName:String
    let description:String
    let releaseDate:Date
    let gamePicture:String
    let rating:Int
    let type:String
}

struct BestRate {
    let idGame:Int
    let name:String
    let companyName:String
    let description:String
    let releaseDate:Date
    let gamePicture:String
    let rating:Int
    let type:String
}

class DiscoverController: UIViewController, UICollectionViewDataSource {
     
    //Widgets
    //var
    var topPicks=[TopPicks]()
    var trendingGames=[TrendingGames]()
    var bestRate=[BestRate]()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

 
    //Functions
    
    
    func getTopPicks() {
    let url=URL(string: "http://192.168.64.1:3000/GetTopPicksGames")
    // let url = URL(string: "http://192.168.247.1:3000/GetTopPicksGames")
    
    }
    
    
    
    func getTrendingGames() {
    let url=URL(string: "http://192.168.64.1:3000/GetTrendingGames")
    // let url = URL(string: "http://192.168.247.1:3000/GetTrendingGames")
    
    }
    
    func getBestRateGames() {
    let url=URL(string: "http://192.168.64.1:3000/GetBestRateGames")
    // let url = URL(string: "http://192.168.247.1:3000/GetBestRateGames")
    
    }
    
    
    //IBActions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    }
    
    @IBAction func search(_ sender: Any) {
    }
    
    
}
