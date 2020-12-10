//
//  MainTabController.swift
//  Genus
//
//  Created by Orionsyrus24 on 12/9/20.
//


import UIKit

class MainTabController : UITabBarController {
    
    var id:Int = 0
    var Username:String = "Full Name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewControllers = viewControllers else {
        return
        }
        for viewController in viewControllers {
        if let profileNavigationController = viewController as? ProfileNavigationController {
            if let profileViewController = profileNavigationController.viewControllers.first as? ProfileController {
                profileViewController.Username=Username
                profileViewController.id=id
            }
        }
         
            
            if let wishListNavigationController = viewController as? WishListNavigationController {
                if let WishListViewController = wishListNavigationController.viewControllers.first as? WishListController {
                WishListViewController.id=id
                
            }
            }
            
            if let libraryNavigationController = viewController as? LibraryNavigationController {
                if let libraryViewController = libraryNavigationController.viewControllers.first as? LibraryController {
                libraryViewController.id=id
                
            }
                
            }
        }
    }
    
   
}
