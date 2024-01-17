//
//  MenuCoordinator.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

final class MenuCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: MenuFactory
    
    init(navigation: UINavigationController, factory: MenuFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeModule()
        controller.setupTabBarItem(
            title: "Menu",
            image: "person",
            selectedImage: "person.fill"
        )
        navigation.pushViewController(controller, animated: true)
    }
}
