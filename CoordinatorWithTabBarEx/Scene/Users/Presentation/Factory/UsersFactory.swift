//
//  HomeFactory.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//
import UIKit

protocol UsersFactory {
    func makeModule(coordinator: UsersViewControllerCoordinator) -> UIViewController
    
    func makeUserDetailCoordinator(
        navigation: UINavigationController,
        user: User
    ) -> Coordinator
}

struct UsersFactoryImpl: UsersFactory {
    private(set) var endPoint: String
    private(set) var appContainer: AppContainer
    
    func makeModule(coordinator: UsersViewControllerCoordinator) -> UIViewController {
        let randomUsersRepository = RandomUsersRepositoryImpl(apiClient: appContainer.apiClient)
        let loadRandomUsersUseCase = LoadRandomUsersUseCaseImpl(
            randomUsersRepository: randomUsersRepository,
            endPoint: endPoint
        )
        let lastPageValidationUseCase = LastPageValidationUseCaseImpl()
        let usersViewModel = UsersViewModelImpl(
            loadRandomUsersUseCase: loadRandomUsersUseCase,
            lastPageValidationUseCase: lastPageValidationUseCase
        )
        let controller = UsersViewController(
            viewModel: usersViewModel,
            coordinator: coordinator
        )
        controller.title = "Users"
        return controller
    }
    
    func makeUserDetailCoordinator(
        navigation: UINavigationController,
        user: User
    ) -> Coordinator {
        let userDetailFactory = UserDetailFactoryImpl(user: user)
        return UserDetailCoordinator(
            navigation: navigation,
            factory: userDetailFactory
        )
    }
}
