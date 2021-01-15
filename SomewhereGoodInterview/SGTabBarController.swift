//
//  SGTabBarControllerViewController.swift
//  SomewhereGoodInterview
//
//  Created by Vanessa Flores on 1/15/21.
//

import UIKit

class SGTabBarController: UITabBarController {
    
    var directMessagesNavigationController: UINavigationController {
        let viewController = DirectMessagesListViewController()
        viewController.title = "Somehere Good"
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        return UINavigationController(rootViewController: viewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [directMessagesNavigationController]
    }
}
