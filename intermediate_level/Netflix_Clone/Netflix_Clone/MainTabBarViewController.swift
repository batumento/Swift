//
//  ViewController.swift
//  Netflix_Clone
//
//  Created by Batuhan Emiroğlu on 13.04.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let v1 = UINavigationController(rootViewController: HomeViewController())
        let v2 = UINavigationController(rootViewController: UpcomingViewController())
        let v3 = UINavigationController(rootViewController: SearchViewController())
        let v4 = UINavigationController(rootViewController: DownloadsViewController())

        v1.tabBarItem.image = UIImage(systemName: "house")
        v2.tabBarItem.image = UIImage(systemName: "play.circle")
        v3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        v4.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")

        setViewControllers([v1, v2, v3, v4], animated: true)
    }


}

