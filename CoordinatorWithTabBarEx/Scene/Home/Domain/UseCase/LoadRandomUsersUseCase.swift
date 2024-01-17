//
//  LoadRandomUsersUseCase.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

protocol LoadRandomUsersUseCase {
    func execute() async -> Result<[User], Error>
}

struct LoadRandomUsersUseCaseImpl: LoadRandomUsersUseCase {
    private(set) var randomUsersRepository: RandomUsersRepository
    private(set) var endPoint: String
    
    func execute() async -> Result<[User], Error> {
        do {
            let users = try await randomUsersRepository
                .fetchRandomUsers(endPoint: endPoint)
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
    
}
