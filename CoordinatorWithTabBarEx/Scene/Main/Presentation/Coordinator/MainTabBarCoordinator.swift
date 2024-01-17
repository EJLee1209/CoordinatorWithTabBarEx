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
    
    private var homeCoordinator: Coordinator?
    private var menuCoordinator: Coordinator?
    private var logInCoordinator: Coordinator?
    
    
    init(factory: MainTabBarFactory, window: UIWindow) {
        self.factory = factory
        self.window = window
    }
    
    func start() {
        mainTabBar = factory.makeModule()
        
        let homeCoordinator = factory.makeHomeCoordinator(delegate: self)
        let homeNavigationController = homeCoordinator.navigation
        homeCoordinator.start()
        self.homeCoordinator = homeCoordinator
        
        let menuCoordinator = factory.makeMenuCoordinator()
        let menuNavigationController = menuCoordinator.navigation
        menuCoordinator.start()
        self.menuCoordinator = menuCoordinator
        
        mainTabBar?.viewControllers = [
            homeNavigationController, menuNavigationController
        ]
        
        window.rootViewController = mainTabBar
        window.makeKeyAndVisible()
    }
}

extension MainTabBarCoordinator: HomeCoordinatorDelegate {
    func didFinishLogOut() {
        guard let homeNavigationController = homeCoordinator?.navigation else { return }
        
        let logInCoordinator = factory.makeLogInCoordinator(
            navigation: homeNavigationController,
            delegate: self
        )
        logInCoordinator.start()
        self.logInCoordinator = logInCoordinator
    }
}

extension MainTabBarCoordinator: LoginCoordinatorDelegate {
    func didFinishLogIn() {
        guard let homeNavigationController = homeCoordinator?.navigation else { return }
        
        homeNavigationController.dismiss(animated: true)
        self.logInCoordinator = nil
    }
}
