//
//  UIViewController+.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

extension UIViewController {
    func setupTabBarItem(
        title: String?,
        image: String,
        selectedImage: String
    ) {
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: image),
            selectedImage: UIImage(systemName: selectedImage)
        )
        
        self.tabBarItem = tabBarItem
    }
}
