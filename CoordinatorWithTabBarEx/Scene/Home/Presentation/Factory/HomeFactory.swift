//
//  HomeFactory.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//
import UIKit

protocol HomeFactory {
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController
}

struct HomeFactoryImpl: HomeFactory {
    private(set) var endPoint: String
    private(set) var appContainer: AppContainer
    
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController {
        let randomUsersRepository = RandomUsersRepositoryImpl(apiClient: appContainer.apiClient)
        let loadRandomUsersUseCase = LoadRandomUsersUseCaseImpl(
            randomUsersRepository: randomUsersRepository,
            endPoint: endPoint
        )
        let lastPageValidationUseCase = LastPageValidationUseCaseImpl()
        let homeViewModel = HomeViewModelImpl(
            loadRandomUsersUseCase: loadRandomUsersUseCase,
            lastPageValidationUseCase: lastPageValidationUseCase
        )
        let controller = HomeViewController(
            viewModel: homeViewModel,
            coordinator: coordinator
        )
        controller.title = "Home"
        return controller
    }
}
