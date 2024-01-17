//
//  MenuFactory.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//
import UIKit

protocol MenuFactory {
    func makeModule() -> UIViewController
}

struct MenuFactoryImpl: MenuFactory {
    func makeModule() -> UIViewController {
        let controller = MenuViewController()
        controller.title = "Menu"
        return controller
    }
}
