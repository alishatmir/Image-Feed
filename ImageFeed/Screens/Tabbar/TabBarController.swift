//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Алина Тихомирова on 15.06.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        configureControllers()
    }
    
    private func configureAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.backgroundImage = .init()
        tabBarAppearance.backgroundColor = .ypBlack
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        if #available(iOS 15, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        tabBar.tintColor = .ypWhite
        tabBar.barTintColor = .ypBlack
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .ypBlack
    }
    
    private func configureControllers() {
        let imageListController = ImagesListViewController()
        imageListController.tabBarItem = UITabBarItem(
            title: nil,
            image: .init(resource: .tabEditorialNoActive),
            selectedImage: .init(resource: .tabEditorialActive)
        )
        
        let profileController = ProfileViewController()
        profileController.tabBarItem = UITabBarItem(
            title: nil,
            image: .init(resource: .tabProfileNoActive),
            selectedImage: .init(resource: .tabProfileActive)
        )
        
        viewControllers = [imageListController, profileController]
    }
}
