//
//  UserDetailCoordinator.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//
import UIKit

final class UserDetailCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: UserDetailFactory
    
    init(navigation: UINavigationController, factory: UserDetailFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeModule()
        navigation.pushViewController(controller, animated: true)
    }
}
