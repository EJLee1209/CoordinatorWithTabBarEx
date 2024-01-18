//
//  HomeCoordinator.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

protocol UsersCoordinatorDelegate: AnyObject {
    func didFinishLogOut()
}

final class UsersCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: UsersFactory
    weak var delegate: UsersCoordinatorDelegate?
    
    init(
        navigation: UINavigationController,
        factory: UsersFactory,
        delegate: UsersCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeModule(coordinator: self)
        controller.setupTabBarItem(
            title: "Users",
            image: "person",
            selectedImage: "person.fill"
        )
        navigation.pushViewController(controller, animated: true)
    }
}

extension UsersCoordinator: UsersViewControllerCoordinator {
    func didFinishLogOut() {
        delegate?.didFinishLogOut()
    }
    
    func didSelectUser() {
        let userDetailCoordinator = factory.makeUserDetailCoordinator(navigation: navigation)
        userDetailCoordinator.start()
    }
}
