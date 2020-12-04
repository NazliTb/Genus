//
//  PopUpWindow .swift
//  Genus
//
//  Created by Orionsyrus24 on 12/1/20.
//

import UIKit

private class PopUpWindowView: UIView {
    let popupView = UIView(frame: CGRect.zero)
    
    let popupTitle = UILabel(frame: CGRect.zero)
    
    let popupProfilePicture = UIImagePickerController()
    
    let popupUsernameLabel = UILabel(frame: CGRect.zero)
    let popupUsernameTextField = UITextField(frame: CGRect.zero)
    
    let popupPasswordLabel = UILabel(frame: CGRect.zero)
    let popupPasswordTextField = UITextField(frame: CGRect.zero)
    
    let popupButton = UIButton(frame: CGRect.zero)
        
    let BorderWidth: CGFloat = 2.0
    
    
    init() {
    super.init(frame: CGRect.zero)
    // Semi-transparent background
    backgroundColor = UIColor.black.withAlphaComponent(0.3)
                
    // Popup Background
    popupView.backgroundColor = UIColor.white
    popupView.layer.borderWidth = BorderWidth
    popupView.layer.masksToBounds = true
    popupView.layer.borderColor = UIColor.white.cgColor
                
    // Popup Title
    popupTitle.textColor = UIColor.black
    popupTitle.backgroundColor = UIColor.white
    popupTitle.layer.masksToBounds = true
    popupTitle.adjustsFontSizeToFitWidth = true
    popupTitle.clipsToBounds = true
    popupTitle.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
    popupTitle.numberOfLines = 1
    popupTitle.textAlignment = .center
                
    // Popup Usernamelabel Text
    popupUsernameLabel.textColor = UIColor.black
    popupUsernameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    popupUsernameLabel.numberOfLines = 0
    popupUsernameLabel.textAlignment = .left
    
    // Popup UsernameTextField
    popupUsernameTextField.textColor = UIColor.black
    popupUsernameTextField.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    popupUsernameTextField.textAlignment = .left
                
    // Popup Passwordlabel Text
    popupPasswordLabel.textColor = UIColor.black
    popupPasswordLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    popupPasswordLabel.numberOfLines = 0
    popupPasswordLabel.textAlignment = .left
        
    // Popup PasswordTextField
        
    popupUsernameTextField.textColor = UIColor.black
    popupUsernameTextField.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    popupUsernameTextField.textAlignment = .left
        
    // Popup
    // Popup Button
    popupButton.setTitleColor(UIColor.white, for: .normal)
    popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
    popupButton.backgroundColor = UIColor.black
                
    popupView.addSubview(popupTitle)
    //popupView.addSubview(popupProfilePicture)
    popupView.addSubview(popupUsernameLabel)
    popupView.addSubview(popupUsernameTextField)
    popupView.addSubview(popupPasswordLabel)
    popupView.addSubview(popupPasswordTextField)
    popupView.addSubview(popupButton)
                
    // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
    addSubview(popupView)
                
                
    // PopupView constraints
    popupView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    popupView.widthAnchor.constraint(equalToConstant: 293),
    popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  

                
    // PopupButton constraints
    popupButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
    popupButton.heightAnchor.constraint(equalToConstant: 44),
    popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
    popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
    popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth)
    ])
                
    }
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    
    }
    

class PopUpWindow: UIViewController {
    
    private let popUpWindowView = PopUpWindowView()

    init(title: String,Usernamelabel: String, Passwordlabel : String, buttontext: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
             
        popUpWindowView.popupTitle.text = title
        popUpWindowView.popupUsernameLabel.text = Usernamelabel
        popUpWindowView.popupPasswordLabel.text = Passwordlabel
        
        popUpWindowView.popupButton.setTitle(buttontext, for: .normal)
        
        
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        view = popUpWindowView
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
            self.dismiss(animated: true, completion: nil)
        }
  
}
