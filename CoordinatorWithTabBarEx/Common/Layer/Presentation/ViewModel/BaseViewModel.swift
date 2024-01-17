//
//  BaseViewModel.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    
    func viewDidLoad()
}
