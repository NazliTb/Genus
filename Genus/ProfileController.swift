//
//  ProfileController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit

class ProfileController: UIViewController {
    
    //Widgets
    var id:Int=0
    var Username:String = "Full Name"
    var gamenbr: String = "0"
    var favnbr: String  = "0"
    var wishnbr: String = "0"
   
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var gameNbr: UILabel!
    
    @IBOutlet weak var favNbr: UILabel!
    
    @IBOutlet weak var wishNbr: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
  
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        username.text=Username
        gameNbr.text=gamenbr
        favNbr.text=favnbr
        wishNbr.text=wishnbr
        
    }


    //IBActions
    
    @IBAction func editProfileAction(_ sender: Any) {
    var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(title: "Edit Profile", Usernamelabel:"Username : ",Passwordlabel: "Password : ", buttontext: "Update")
    self.present(popUpWindow, animated: true, completion: nil)    }
    
    @IBAction func goMyGamesAction(_ sender: Any) {
    }
    
    
    @IBAction func goMyWishlistAction(_ sender: Any) {
    }
    
    
    @IBAction func goMyAccountAction(_ sender: Any) {
    }
    
    
    @IBAction func nightModeAction(_ sender: Any) {
    }
    
    
    
    @IBAction func notificationAction(_ sender: Any) {
    }
    
    
    @IBAction func languageAction(_ sender: Any) {
    }
    
    
    @IBAction func helpAction(_ sender: Any) {
    }
    
    
    @IBAction func signoutAction(_ sender: Any) {
    }
    
    
    
}
