//
//  LoadRandomUsersRepository.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

struct RandomUsersRepositoryImpl: RandomUsersRepository {
    
    private(set) var apiClient: ApiClientService
    
    func fetchRandomUsers(endPoint: String) async throws -> [User] {
        return try await apiClient.request(
            endPoint: endPoint,
            decodeType: ResultRandomUsersDTO.self
        ).toDomain()
    }
}
