//
//  LogInCoordinator.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didFinishLogIn()
}

final class LogInCoordinator: Coordinator {
    private let factory: LogInFactory
    var navigation: UINavigationController
    weak var delegate: LoginCoordinatorDelegate?
    
    init(
        navigation: UINavigationController,
        factory: LogInFactory,
        delegate: LoginCoordinatorDelegate?
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeModule(coordinator: self)
        controller.modalPresentationStyle = .fullScreen
        navigation.present(controller, animated: true)
    }
}

extension LogInCoordinator: LoginViewControllerCoordinator {
    func didFinishLogIn() {
        delegate?.didFinishLogIn()
    }
}
