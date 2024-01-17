//
//  AppContainer.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

protocol AppContainer {
    var apiClient: ApiClientService { get }
}

struct AppContainerImpl: AppContainer {
    var apiClient: ApiClientService = ApiClientServiceImpl()
}

