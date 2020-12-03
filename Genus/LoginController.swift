//
//  LoginController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//


import UIKit
import Alamofire
class LoginController: UIViewController {
    
    //Var
    var nbrGames: Any = 0
    
    //Widgets

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //Functions
    func alert(message: String, title: String ) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
         }
    
    func linkLoginProfile()
    {
        self.performSegue(withIdentifier: "login_profile", sender: nbrGames)
        
    }
    
 
    
 
    
    func getGamesNbr(idUser: String)
    {
        
    
        AF.request("http://192.168.64.1:3000/GetGamesNbr/"+idUser).responseJSON{ (response) in
            switch response.result {
                    
                    case .success(let value):
                         self.nbrGames=value
                         self.linkLoginProfile()
                    
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
           
            
        }
        
   
       print(nbrGames)
        
    }
    
    func getFavNbr(idUser: String)
    {
       
        var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/GetFavouriteGamesNbr/"+idUser)!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
    let responseData = String(data: data!, encoding: String.Encoding.utf8)
    DispatchQueue.main.async {
            
    let res = responseData!.replacingOccurrences(of: "\"", with: "")
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
    vc.favnbr=res
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    })
        task.resume()
    }
    
    func getWishNbr(idUser: String)
    {
        
    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/GetWishGamesNbr/"+idUser)!)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
    let responseData = String(data: data!, encoding: String.Encoding.utf8)
    DispatchQueue.main.async {
            
    let res = responseData!.replacingOccurrences(of: "\"", with: "")
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
    vc.wishnbr=res
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    })
        task.resume()
    }
    
    //IBActions
    
    @IBAction func LoginAction(_ sender: Any) {
        if(email.text=="" || password.text=="")
        {
            alert(message: "Please give your email and password", title: "Warning")
        }
        else {
    let params = ["email":email.text, "password":password.text] as! Dictionary<String, String>
    var request = URLRequest(url: URL(string: "http://192.168.64.1:3000/login")!)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            
        do {
            let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,AnyObject>
          
                let name = json["username"] as! String
                let idUser=json["idUser"] as! Int
                
                DispatchQueue.main.async {
               
                let error1="Wrong password"
                let error2="User doesnt exist !"
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                let res = responseData!.replacingOccurrences(of: "\"", with: "")
                if(res.caseInsensitiveCompare(error1) == .orderedSame || res.caseInsensitiveCompare(error2) == .orderedSame) {
                self.alert(message:res,title:"Error")
               
                }
                else {
                  
                    self.alert(message:"Welcome you are connected !",title:"Information")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                    
                    
                    vc.Username=name as! String
                    var id1="\(idUser)"
                    vc.id=idUser
                    self.getGamesNbr(idUser: id1)
                  
                   /* self.getFavNbr(idUser: id1)
                    self.getWishNbr(idUser: id1) */
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.present(vc, animated: true, completion: nil)
                   
                
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

   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "login_profile") {
        let viewController = segue.destination as? ProfileController
        viewController!.gamesnbr=nbrGames
        }
    }
    
    @IBAction func JoinAction(_ sender: Any) {
    
    }
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
    }
    
    
    @IBAction func goTwitterAction(_ sender: Any) {
    }


    @IBAction func goFacebookAction(_ sender: Any) {
    }
    

    @IBAction func goInstagramAction(_ sender: Any) {
    }
}

