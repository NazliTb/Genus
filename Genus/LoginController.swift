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
           
           if(message=="Welcome you are connected !")
           {
            //self.present(alertController, animated: true, completion: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: nil) 
           }
           else {
            self.present(alertController, animated: true, completion: nil)
           }
        
         }
    
    
    
 /*   func linkLoginProfile()
    {
        self.performSegue(withIdentifier: "data", sender: data)
        
    }*/
    
 
   
 
    
    func getGamesNbr(idUser: String,completion: @escaping (Any) -> Void)
    {
        
    
        AF.request("http://192.168.64.1:3000/GetGamesNbr/"+idUser).responseJSON{ (response) in
            switch response.result {
                    
                    case .success(let value):
                        // self.nbrGames=value
                       
                       
                      
                        completion(value)
                        
                    case .failure(let error):
                        print(error)
                        break
                    }
           
            
        }
        
        
    }
    
    func getFavNbr(idUser: String,completion: @escaping (Any) -> Void)
    {
       
        AF.request("http://192.168.64.1:3000/GetGamesNbr/"+idUser).responseJSON{ (response) in
            switch response.result {
                    
                    case .success(let value):
                         //self.nbrFav=value
                        completion(value)
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
           
    }
    }
    
    func getWishNbr(idUser: String,completion: @escaping (Any) -> Void)
    {
        
  
        AF.request("http://192.168.64.1:3000/GetWishGamesNbr/"+idUser).responseJSON{ (response) in
            switch response.result {
                    
                    case .success(let value):
                         //self.nbrFav=value
                        completion(value)
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
           
    }
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
                   // self.alert(message:"Welcome you are connected !",title:"Information")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                    vc.Username=name
                     let id1="\(idUser)"
                     vc.id=idUser
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.present(vc, animated: true, completion: nil)
                    
                   
                    
                    
                    
                 
                    /*self.getGamesNbr(idUser: id1) { (response) in
                        
                        vc.gamesnbr=response
                        
                        
                    }
                    print(vc.gamesnbr)
                    print(vc.Username)
                  
                    self.getFavNbr(idUser: id1) { (response) in
                        vc.favnbr=response
                       

                    }
                    self.getWishNbr(idUser: id1) { (response) in
                        vc.favnbr=response
                        

                    }*/
                    //self.linkLoginProfile()
                 
                   
                   
                
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

   
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? ProfileController
        if (segue.identifier == "data")
        
        {viewController!.data=data}
        
        
    }*/
    
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

