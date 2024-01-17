//
//  SceneDelegate.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var mainTabBarCoordinator: MainTabBarCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let appContainer = AppContainerImpl()
        let mainTabBarFactory = MainTabBarFactoryImpl(appContainer: appContainer)
        mainTabBarCoordinator = MainTabBarCoordinator(
            factory: mainTabBarFactory,
            window: window
        )
        mainTabBarCoordinator?.start()
    }

}

