//
//  ProfileController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit
//import PopupDialog

class ProfileController: UIViewController {
    
    //Widgets
    var id:Int=0
    var Username:String = "Full Name"
    var gamesnbr: Any = 0
    var favnbr: Any  = 0
    var wishnbr: String = "0"
  
   
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var gameNbr: UILabel!
    
    @IBOutlet weak var favNbr: UILabel!
    
    @IBOutlet weak var wishNbr: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
  
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        getGamesNbr(idUser:"\(id)") { (nbr,error) in
            if let x = nbr {
                self.gameNbr.text="\(x)"
                
            }
        }
        getFavNbr(idUser:"\(id)") { (nbr,error) in
            if let x = nbr {
                self.favNbr.text="\(x)"
                
            }
        }
        getWishNbr(idUser:"\(id)") { (nbr,error) in
            if let x = nbr {
                self.wishNbr.text="\(x)"
                
            }
        }
        // Do any additional setup after loading the view.
        username.text=Username
    
       
    }

    func getGamesNbr(idUser:String,completionHandler: @escaping (String?,Error?)->
    Void) {
    let url=URL(string: "http://192.168.64.1:3000/GetGamesNbr/"+idUser)!
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let responseData = String(data: data, encoding: String.Encoding.utf8)
    let res = responseData!.replacingOccurrences(of: "\"", with: "")
    completionHandler(res,nil)
    }
    catch let parseErr {
    print(parseErr)
    //completionHandler(nil,parseErr)
    }
    })
    task.resume()
    }
    
    func getFavNbr(idUser:String,completionHandler: @escaping (String?,Error?)->
    Void) {
    let url=URL(string: "http://192.168.64.1:3000/GetFavouriteGamesNbr/"+idUser)!
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let responseData = String(data: data, encoding: String.Encoding.utf8)
    let res = responseData!.replacingOccurrences(of: "\"", with: "")
    completionHandler(res,nil)
    }
    catch let parseErr {
    print(parseErr)
    //completionHandler(nil,parseErr)
    }
    })
    task.resume()
    }
    
    
    func getWishNbr(idUser:String,completionHandler: @escaping (String?,Error?)->
    Void) {
    let url=URL(string: "http://192.168.64.1:3000/GetWishGamesNbr/"+idUser)!
    let task = URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in guard let data = data else { return }
    do {
        let responseData = String(data: data, encoding: String.Encoding.utf8)
    let res = responseData!.replacingOccurrences(of: "\"", with: "")
    completionHandler(res,nil)
    }
    catch let parseErr {
    print(parseErr)
    //completionHandler(nil,parseErr)
    }
    })
    task.resume()
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
