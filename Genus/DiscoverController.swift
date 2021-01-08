//
//  DiscoverController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/9/20.
//

import UIKit


class DiscoverController: UIViewController {

          

    //Widgets
    @IBOutlet weak var tableView: UITableView!
    //var
    var id:Int=0
    var username:String=""
    
   
    
 
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
    }

    
    //IBActions
        
    @IBAction func search(_ sender: Any) {
    }
    
   
    
}

extension DiscoverController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell
        if(indexPath.row == 0) {
        cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
        }
        else if (indexPath.row == 1)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "lastCell", for: indexPath)
        }
        return cell
    }
    
    
}
