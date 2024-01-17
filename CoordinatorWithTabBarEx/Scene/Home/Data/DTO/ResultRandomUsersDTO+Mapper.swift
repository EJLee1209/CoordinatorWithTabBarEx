//
//  ResultRandomUsersDTO+Mapper.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

extension ResultRandomUsersDTO {
    func toDomain() -> [User] {
        results.map {
            let name = "\($0.name.title), \($0.name.first) \($0.name.last)"
            
            return User(
                name: name,
                gender: Gender(rawValue: $0.gender) ?? .unknowned,
                imageUrl: $0.picture.large
            )
        }
    }
}
