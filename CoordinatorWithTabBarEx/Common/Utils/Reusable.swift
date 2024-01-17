//
//  Reusable.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//

protocol Reuseable { }

extension Reuseable {
    static var identifier: String { String(describing: self) }
}
