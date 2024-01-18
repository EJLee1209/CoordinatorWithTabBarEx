//
//  MainTabBarCoordinator.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

final class MainTabBarCoordinator {
    
    private var mainTabBar: UITabBarController?
    private let factory: MainTabBarFactory
    private let window: UIWindow
    
    private var usersCoordinator: Coordinator?
    private var menuCoordinator: Coordinator?
    private var logInCoordinator: Coordinator?
    
    
    init(factory: MainTabBarFactory, window: UIWindow) {
        self.factory = factory
        self.window = window
    }
    
    func start() {
        mainTabBar = factory.makeModule()
        
        let usersCoordinator = factory.makeUsersCoordinator(delegate: self)
        let usersNavigationController = usersCoordinator.navigation
        usersCoordinator.start()
        self.usersCoordinator = usersCoordinator
        
        let menuCoordinator = factory.makeMenuCoordinator()
        let menuNavigationController = menuCoordinator.navigation
        menuCoordinator.start()
        self.menuCoordinator = menuCoordinator
        
        mainTabBar?.viewControllers = [
            usersNavigationController, menuNavigationController
        ]
        
        window.rootViewController = mainTabBar
        window.makeKeyAndVisible()
    }
}

extension MainTabBarCoordinator: UsersCoordinatorDelegate {
    func didFinishLogOut() {
        guard let usersNavigationController = usersCoordinator?.navigation else { return }
        
        let logInCoordinator = factory.makeLogInCoordinator(
            navigation: usersNavigationController,
            delegate: self
        )
        logInCoordinator.start()
        self.logInCoordinator = logInCoordinator
    }
}

extension MainTabBarCoordinator: LoginCoordinatorDelegate {
    func didFinishLogIn() {
        guard let usersNavigationController = usersCoordinator?.navigation else { return }
        
        usersNavigationController.dismiss(animated: true)
        self.logInCoordinator = nil
    }
}
