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
    func makeModule() -> UIViewController {
        UserDetailViewController()
    }
}
