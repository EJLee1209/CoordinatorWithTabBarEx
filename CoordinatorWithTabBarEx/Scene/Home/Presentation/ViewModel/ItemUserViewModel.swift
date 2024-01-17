//
//  ItemUserViewModel.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import Foundation

struct ItemUserViewModel {
    private(set) var user: User
    
    var name: String {
        user.name
    }
    
    var gender: String {
        user.gender.description
    }
    
    var imageUrl: URL? {
        return URL(string: user.imageUrl)
    }
}
