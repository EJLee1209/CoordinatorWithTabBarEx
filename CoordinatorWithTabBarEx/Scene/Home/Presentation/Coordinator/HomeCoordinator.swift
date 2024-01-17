//
//  HomeCoordinator.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func didFinishLogOut()
}

final class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: HomeFactory
    weak var delegate: HomeCoordinatorDelegate?
    
    init(
        navigation: UINavigationController,
        factory: HomeFactory,
        delegate: HomeCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeModule(coordinator: self)
        controller.setupTabBarItem(
            title: "Home",
            image: "house",
            selectedImage: "house.fill"
        )
        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerCoordinator {
    func didFinishLogOut() {
        delegate?.didFinishLogOut()
    }
}
