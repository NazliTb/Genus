//
//  ProfileController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//

import UIKit
import SCLAlertView


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

class ProfileController: UIViewController {
    
    //Widgets
    var id:Int=0
    var Username:String = "Full Name"
    var userPic:String = ""
    var gamesnbr: Any = 0
    var favnbr: Any  = 0
    var wishnbr: Any = 0
  
   
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
        let defaultLink = "http://192.168.64.1:3000/image/"+userPic
       // let defaultLink = "http://192.168.247.1:3000/image/"+userPic
        profilePic.downloaded(from: defaultLink)
    
       
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
    
  
    func alert(message: String, title: String ) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
           }
    
    //IBActions
    
    @IBAction func editProfileAction(_ sender: Any) {
        
    
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true, titleColor: UIColor.init(hexString: "#04D9D9")
        )

        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)

        // Creat the subview
        let subview = UIView(frame: CGRect(x:0,y:0,width:216,height:300))
        let x = (subview.frame.width - 180) / 2
        // Add textfiel
        let textfield1 = UITextField(frame: CGRect(x:x,y:30,width:180,height:40))
        textfield1.layer.borderColor = UIColor.init(hexString: "#04D9D9").cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "username"
        textfield1.textAlignment = NSTextAlignment.left
        subview.addSubview(textfield1)
        
        alert.addButton("Update Username",backgroundColor: UIColor(hexString: "#04D9D9"),textColor: UIColor.white) {
            if(textfield1.text=="")
            {
                self.alert(message: "Please give your username !", title: "Warning")
            }
            else {
                let id: String = "\(self.id)"
                let username=textfield1.text
                let params = ["username":username,"idUser": id] as! Dictionary<String, String>
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/editUsername")!)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
                
            do {
       
                    DispatchQueue.main.async {
                   
                    let error1="Update failed"
                    let error2="User not found"
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    let res = responseData!.replacingOccurrences(of: "\"", with: "")
                    if(res.caseInsensitiveCompare(error1) == .orderedSame || res.caseInsensitiveCompare(error2) == .orderedSame) {
                    self.alert(message:res,title:"Error")
                   
                    }
                    else {
                      
                        let alertController = UIAlertController(title: "Information", message: res, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        { action -> Void in
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                            vc.id=self.id
                            vc.Username=textfield1.text!
                          
                           
                           self.navigationController?.pushViewController(vc, animated: true)
                           self.present(vc, animated: true, completion: nil)
                            
                        }
                        alertController.addAction(OKAction)
                        
                        self.present(alertController, animated: true, completion: nil)
   
                    }
                }
            }
            catch
            {
                
            }

        })
        
        task.resume()
            }
        
                
            }
            
        // Add textfield 2
        let textfield = UITextField(frame: CGRect(x:x,y:textfield1.frame.maxY + 30,width:180,height:40))
        textfield.isSecureTextEntry=true
        textfield.layer.borderColor = UIColor.init(hexString: "#04D9D9").cgColor
        textfield.layer.borderWidth = 1.5
        textfield.layer.cornerRadius = 5
        textfield.placeholder = "old password"
        textfield.textAlignment = NSTextAlignment.left
        subview.addSubview(textfield)
        

        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x:x,y:textfield.frame.maxY + 30,width:180,height:40))
        textfield2.isSecureTextEntry=true
        textfield2.layer.borderColor = UIColor.init(hexString: "#04D9D9").cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield2.placeholder = "password"
        textfield2.textAlignment = NSTextAlignment.left
        subview.addSubview(textfield2)
        
        //Add textfield 3

        let textfield3 = UITextField(frame: CGRect(x:x,y:textfield2.frame.maxY + 30,width:180,height:40))
        textfield3.isSecureTextEntry=true
        textfield3.layer.borderColor = UIColor.init(hexString: "#04D9D9").cgColor
        textfield3.layer.borderWidth = 1.5
        textfield3.layer.cornerRadius = 5
        textfield3.placeholder = "confirm password"
        textfield3.textAlignment = NSTextAlignment.left
        subview.addSubview(textfield3)
        
        
        
        
        alert.addButton("Update password",backgroundColor: UIColor(hexString: "#04D9D9"),textColor: UIColor.white) {
        
            if(textfield.text=="" || textfield2.text=="" || textfield3.text=="")
            {
               
                    self.alert(message: "Please fill in all fields !", title: "Warning")
               
                
            }
          
            else if (textfield2.text==textfield3.text)
              
        
            {
                let id: String = "\(self.id)"
                let oldpassword=textfield.text
                let password=textfield2.text
                let params = ["old_password":oldpassword,"idUser": id, "new_password" :password] as! Dictionary<String, String>
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/editPassword")!)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
                
            do {
       
                    DispatchQueue.main.async {
                   
                    let error1="Update failed"
                    let error2="User not found"
                    let error3="old password is wrong"
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    let res = responseData!.replacingOccurrences(of: "\"", with: "")
                    if(res.caseInsensitiveCompare(error1) == .orderedSame || res.caseInsensitiveCompare(error2) == .orderedSame || res.caseInsensitiveCompare(error3) == .orderedSame) {
                    self.alert(message:res,title:"Error")
                   
                    }
                    else {
                      
                        let alertController = UIAlertController(title: "Information", message: res, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        { action -> Void in
                        
                            
                        }
                        alertController.addAction(OKAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
          
               
                     
           
                    }
                }
            }
            catch
            {
                
            }

        })
        
        task.resume()
            }
        
                else {
                    self.alert(message: "Both passwords should be same", title: "Warning")
                }
   
       
        }
        
        
    
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        
        
        
       

       alert.showEdit("Edit Profil", subTitle:"", closeButtonTitle:"Close", timeout: nil,colorStyle: 0x04D9D9, colorTextButton: 0xFFFFFF, circleIconImage:UIImage(named:""), animationStyle:SCLAnimationStyle.noAnimation)
      
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
