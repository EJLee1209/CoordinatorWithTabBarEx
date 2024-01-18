//
//  UserDetailFactory.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//

import UIKit

protocol UserDetailFactory {
    func makeModule() -> UIViewController
}

struct UserDetailFactoryImpl: UserDetailFactory {
    private(set) var user: User
    
    func makeModule() -> UIViewController {
        let userDetailViewModel = UserDetailViewModelImpl(user: user)
        return UserDetailViewController(viewModel: userDetailViewModel)
    }
}
