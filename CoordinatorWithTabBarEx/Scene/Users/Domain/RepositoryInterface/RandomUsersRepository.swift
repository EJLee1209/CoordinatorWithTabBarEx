//
//  RandomUsersRepository.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

protocol RandomUsersRepository {
    func fetchRandomUsers(endPoint: String) async throws -> [User]
}
