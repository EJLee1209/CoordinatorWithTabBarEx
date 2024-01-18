//
//  MainTabBarFactory.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

protocol MainTabBarFactory {
    func makeModule() -> UITabBarController
    
    func makeUsersCoordinator(
        delegate: UsersCoordinatorDelegate
    ) -> Coordinator
    
    func makeMenuCoordinator() -> Coordinator
    
    func makeLogInCoordinator(
        navigation: UINavigationController,
        delegate: LoginCoordinatorDelegate
    ) -> Coordinator
}

struct MainTabBarFactoryImpl: MainTabBarFactory {
    
    private(set) var appContainer: AppContainer
    
    func makeModule() -> UITabBarController {
        MainTabBarController()
    }
    
    func makeUsersCoordinator(delegate: UsersCoordinatorDelegate) -> Coordinator {
        let usersFactory = UsersFactoryImpl(
            endPoint: EndPoint.BaseUrl,
            appContainer: appContainer
        )
        return UsersCoordinator(
            navigation: UINavigationController(),
            factory: usersFactory,
            delegate: delegate
        )
    }
    
    func makeMenuCoordinator() -> Coordinator {
        let menuFactory = MenuFactoryImpl()
        return MenuCoordinator(
            navigation: UINavigationController(),
            factory: menuFactory
        )
    }
    
    func makeLogInCoordinator(
        navigation: UINavigationController,
        delegate: LoginCoordinatorDelegate
    ) -> Coordinator {
        let logInFactory = LogInFactoryImpl()
        return LogInCoordinator(
            navigation: navigation,
            factory: logInFactory,
            delegate: delegate
        )
    }
}
