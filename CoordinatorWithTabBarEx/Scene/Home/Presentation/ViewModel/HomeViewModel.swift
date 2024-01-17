//
//  HomeViewModel.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import Combine

protocol HomeViewModel: BaseViewModel {
    var itemUsersCount: Int { get }
    
    func makeItemUserViewModel(row: Int) -> ItemUserViewModel
}

final class HomeViewModelImpl: HomeViewModel {
    var itemUsersCount: Int {
        return users.count
    }
    
    var state: PassthroughSubject<StateController, Never> = .init()
    
    private let loadRandomUsersUseCase: LoadRandomUsersUseCase
    private var users: [User] = []
    
    init(loadRandomUsersUseCase: LoadRandomUsersUseCase) {
        self.loadRandomUsersUseCase = loadRandomUsersUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            let result = await loadRandomUsersUseCase.execute()
            updateRandomUsers(useCaseResult: result)
        }
    }
    
    private func updateRandomUsers(useCaseResult: Result<[User], Error>) {
        switch useCaseResult {
        case .success(let users):
            self.users = users
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func makeItemUserViewModel(row: Int) -> ItemUserViewModel {
        let user = users[row]
        let itemUserViewModel = ItemUserViewModel(user: user)
        return itemUserViewModel
    }
    
}
