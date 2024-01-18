//
//  HomeViewModel.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import Combine

protocol HomeViewModel: BaseViewModel {
    var itemUsersCount: Int { get }
    var isLastPage: Bool { get }
    func makeItemUserViewModel(row: Int) -> ItemUserViewModel
}

final class HomeViewModelImpl: HomeViewModel {
    var itemUsersCount: Int {
        users.count
    }
    
    var isLastPage: Bool {
        lastPageValidationUseCase.isLastPage
    }
    
    var state: PassthroughSubject<StateController, Never> = .init()
    
    private let loadRandomUsersUseCase: LoadRandomUsersUseCase
    private var lastPageValidationUseCase: LastPageValidationUseCase
    private var users: [User] = []
    
    init(
        loadRandomUsersUseCase: LoadRandomUsersUseCase,
        lastPageValidationUseCase: LastPageValidationUseCase
    ) {
        self.loadRandomUsersUseCase = loadRandomUsersUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
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
            self.users.append(contentsOf: users)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func makeItemUserViewModel(row: Int) -> ItemUserViewModel {
        checkAndMoreItems(row: row)
        let user = users[row]
        let itemUserViewModel = ItemUserViewModel(user: user)
        return itemUserViewModel
    }
    
    private func checkAndMoreItems(row: Int) {
        lastPageValidationUseCase.checkAndMoreLoadItems(
            renderedRow: row,
            itemsCount: users.count,
            action: viewDidLoad
        )
    }
    
}
