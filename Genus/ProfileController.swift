//
//  ProfileController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit
import SCLAlertView

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
    
    //Functions

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
    
    }
    })
    task.resume()
    }
    
    
    //IBActions
    
    @IBAction func editProfileAction(_ sender: Any) {
        
     
        /*let appearance = SCLAlertView.SCLAppearance(/*kTitleFont:UIFont(name: "Orbitron", size: 20)!, kTextFont: UIFont(name: "Orbitron", size: 20)!, kButtonFont: UIFont(name: "Orbitron", size: 20)!,*/kCircleHeight:70, kCircleIconHeight: 100, kWindowWidth: 300, kWindowHeight: 1000, showCloseButton: true,circleBackgroundColor: UIColor(red: 255, green: 255, blue: 255, alpha: 1), contentViewBorderColor:UIColor(red: 255, green: 255, blue: 255, alpha: 1))
        let popup = SCLAlertView(appearance: appearance)
        popup.addTextField("username")
        popup.addTextField("password")
        popup.addTextField("cPassword")
    
        popup.showCustom("Edit Profile", subTitle: "", color:UIColor(red: 255, green: 255, blue: 255, alpha: 1), icon: UIImage(named:"Elements_Genus1.1")!)*/
        
        // Example of using the view to add two text fields to the alert
        // Create the subview
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )

        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)

        // Creat the subview
        let subview = UIView(frame: CGRect(x:0,y:0,width:250,height:200))
        let x = (subview.frame.width - 180) / 2
        // Add textfiel
        let textfield1 = UITextField(frame: CGRect(x:x,y:10,width:180,height:25))
        textfield1.layer.borderColor = UIColor.black.cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)

        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x:x,y:textfield1.frame.maxY + 30,width:180,height:25))
        textfield2.isSecureTextEntry=true
        textfield2.layer.borderColor = UIColor.black.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        //Add textfield 3

        let textfield3 = UITextField(frame: CGRect(x:x,y:textfield2.frame.maxY + 30,width:180,height:25))
        textfield3.isSecureTextEntry=true
        textfield3.layer.borderColor = UIColor.black.cgColor
        textfield3.layer.borderWidth = 1.5
        textfield3.layer.cornerRadius = 5
        textfield3.placeholder = "Confirm Password"
        textfield3.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield3)
        
        
        
        
        alert.addButton("Update",backgroundColor: UIColor.cyan,textColor: UIColor.blue) {
        print("Updated")}
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        
        

        

        alert.showInfo("Edit Profile", subTitle:"", closeButtonTitle:"Close", timeout: nil,colorStyle: 0x04D9D9, colorTextButton: 0x111C59, circleIconImage:UIImage(named:"Elements_Genus1.1")!, animationStyle:SCLAnimationStyle.noAnimation)
      
    }
    
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
