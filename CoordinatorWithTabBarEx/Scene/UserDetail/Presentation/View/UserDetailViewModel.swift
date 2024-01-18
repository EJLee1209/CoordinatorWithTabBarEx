//
//  UserDetailViewModel.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//

import Foundation

protocol UserDetailViewModel {
    var name: String { get }
    var imageUrl: URL? { get }
    var gender: String { get }
}

struct UserDetailViewModelImpl: UserDetailViewModel {
    var name: String {
        user.name
    }
    
    var imageUrl: URL? {
        URL(string: user.imageUrl)
    }
    
    var gender: String {
        user.gender.description
    }
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
}
