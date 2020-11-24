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


    //IBActions
    
    @IBAction func registerAction(_ sender: Any) {
    }
}
