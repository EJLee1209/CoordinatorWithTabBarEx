//
//  LogInFactory.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

protocol LogInFactory {
    func makeModule(
        coordinator: LoginViewControllerCoordinator
    ) -> UIViewController
}

struct LogInFactoryImpl: LogInFactory {
    func makeModule(
        coordinator: LoginViewControllerCoordinator
    ) -> UIViewController {
        LoginViewController(coordinator: coordinator)
    }
}
