//
//  LoginController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//


import UIKit

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
    func alertErrorLogin(message: String, title: String ) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
         }
    
    
    
    func alertLogin(message: String, title: String ) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: nil)
            
           })
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
         }
    
    
    //IBActions
    
    @IBAction func LoginAction(_ sender: Any) {
        if(email.text=="" || password.text=="")
        {
            alertErrorLogin(message: "Please give your email and password", title: "Warning")
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
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    
                    
                       
                    
                    }
                    catch {
                        
                }
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                                   
                                
                                    
              
        
        DispatchQueue.main.async {
           
            let error1="Wrong password"
            let error2="User doesnt exist !"
            
            let res = responseData!.replacingOccurrences(of: "\"", with: "")
            if(res.caseInsensitiveCompare(error1) == .orderedSame || res.caseInsensitiveCompare(error2) == .orderedSame) {
            self.alertErrorLogin(message:res,title:"Error")
            
            
           }
            else {
                self.alertLogin(message:"Welcome you are connected !",title:"Information")
           }
        }
    })
    
    task.resume()
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

