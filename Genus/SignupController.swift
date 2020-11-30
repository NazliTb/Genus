//
//  SignupController.swift
//  Genus
//
//  Created by Orionsyrus24 on 11/24/20.
//


import UIKit

class SignupController: UIViewController {
    
    //Widgets
    
   
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cPassword: UITextField!
    
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
    //IBActions
    
    @IBAction func registerAction(_ sender: Any) {
        if (password.text == cPassword.text ) {
        
            let params = ["username":username.text,"email":email.text, "password":password.text] as! Dictionary<String, String>
            var request = URLRequest(url: URL(string: "http://localhost:3000/register")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })

        task.resume()
            
        }
        else
        {
            alert(message: "Both password fields should contain same password", title: "Warning")
        }
        
    }
    
}
