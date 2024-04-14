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
        
        let viewC1 = UINavigationController(rootViewController: HomeViewController())
        let viewC2 = UINavigationController(rootViewController: UpcomingViewController())
        let viewC3 = UINavigationController(rootViewController: SearchViewController())
        let viewC4 = UINavigationController(rootViewController: DownloadsViewController())

        viewC1.tabBarItem.image = UIImage(systemName: "house")
        viewC2.tabBarItem.image = UIImage(systemName: "play.circle")
        viewC3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewC4.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")

        viewC1.title = "Home"
        viewC2.title = "Coming Soon"
        viewC3.title = "Top Search"
        viewC4.title = "Download"

        tabBar.tintColor = .label
        setViewControllers([viewC1, viewC2, viewC3, viewC4], animated: true)
    }


}

