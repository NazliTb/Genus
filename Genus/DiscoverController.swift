//
//  DiscoverController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/9/20.
//

import UIKit

struct TopPicks :Decodable{
    let idGame:Int
    let name:String
    let companyName:String
    let description:String
    let releaseDate:String
    let gamePicture:String
    let rating:Int
    let type:String
}

struct TrendingGames :Decodable{
    let idGame:Int
    let name:String
    let companyName:String
    let description:String
    let releaseDate:String
    let gamePicture:String
    let rating:Int
    let type:String
}

struct BestRate :Decodable{
    let idGame:Int
    let name:String
    let companyName:String
    let description:String
    let releaseDate:String
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
    
    
    @IBOutlet weak var collectionViewTopPicks: UICollectionView!
    @IBOutlet weak var collectionViewTrendingGames: UICollectionView!
    @IBOutlet weak var collectionViewBestRate: UICollectionView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionViewTopPicks.dataSource=self
        collectionViewTrendingGames.dataSource=self
        collectionViewBestRate.dataSource=self
        getTopPicks()
        getTrendingGames()
        getBestRateGames()
        
    }

 
    //Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.collectionViewTopPicks) { return topPicks.count }
        else if (collectionView == self.collectionViewTrendingGames) { return trendingGames.count }
        else { return bestRate.count }
        
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.collectionViewTopPicks) {
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "topPicksCell", for: indexPath) as! TopPicksCollectionViewCell
            cell.name.text=topPicks[indexPath.row].name
            cell.companyName.text=topPicks[indexPath.row].companyName
            cell.gamePicture.contentMode = .scaleAspectFill
        
            let defaultLink = "http://192.168.64.1:3000/image/"+topPicks[indexPath.row].gamePicture
           // let defaultLink = "http://192.168.247.1:3000/image/"+topPicks[indexPath.row].gamePicture
            cell.gamePicture.downloaded(from: defaultLink)
            
            return cell
        }
        else if (collectionView == self.collectionViewTrendingGames) {
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingGamesCell", for: indexPath) as! TrendingGamesCollectionViewCell
            cell.name.text=trendingGames[indexPath.row].name
            cell.companyName.text=trendingGames[indexPath.row].companyName
            cell.gamePicture.contentMode = .scaleAspectFill
            let defaultLink = "http://192.168.64.1:3000/image/"+trendingGames[indexPath.row].gamePicture
           // let defaultLink = "http://192.168.247.1:3000/image/"+trendingGames[indexPath.row].gamePicture
            cell.gamePicture.downloaded(from: defaultLink)
            
            return cell
        }
        else {
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "BestRateCell", for: indexPath) as! BestRateCollectionViewCell
            cell.name.text=bestRate[indexPath.row].name
            cell.companyName.text=bestRate[indexPath.row].companyName
            cell.gamePicture.contentMode = .scaleAspectFill
            let defaultLink = "http://192.168.64.1:3000/image/"+bestRate[indexPath.row].gamePicture
           // let defaultLink = "http://192.168.247.1:3000/image/"+bestRate[indexPath.row].gamePicture
            cell.gamePicture.downloaded(from: defaultLink)
            
            return cell
        }
    }
    
    
    
    
    func getTopPicks() {
    let url=URL(string: "http://192.168.64.1:3000/GetTopPicksGames")
   // let url = URL(string: "http://192.168.247.1:3000/GetTopPicksGames")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
                if (error==nil) {
                do {
                self.topPicks = try JSONDecoder().decode([TopPicks].self, from: data!)
                   
                }
                catch {
                print("ERROR")
                }
                
                DispatchQueue.main.async {
                  
                    self.collectionViewTopPicks.reloadData()
                }
            }
                
            }.resume()
    
    }
    
    
    
    func getTrendingGames() {
    let url=URL(string: "http://192.168.64.1:3000/GetTrendingGames")
  //  let url = URL(string: "http://192.168.247.1:3000/GetTrendingGames")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
                if (error==nil) {
                do {
                    self.trendingGames = try JSONDecoder().decode([TrendingGames].self, from: data!)
                   
                }
                catch {
                print("ERROR")
                }
                
                DispatchQueue.main.async {
                  
                    self.collectionViewTrendingGames.reloadData()
                }
            }
                
            }.resume()
    
    }
    
    func getBestRateGames() {
    let url=URL(string: "http://192.168.64.1:3000/GetBestRateGames")
  //  let url = URL(string: "http://192.168.247.1:3000/GetBestRateGames")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
                if (error==nil) {
                do {
                self.bestRate = try JSONDecoder().decode([BestRate].self, from: data!)
                   
                }
                catch {
                print("ERROR")
                }
                
                DispatchQueue.main.async {
                  
                    self.collectionViewBestRate.reloadData()
                }
            }
                
            }.resume()
    
    }
    
    
    //IBActions
        
    @IBAction func search(_ sender: Any) {
    }
    
}
