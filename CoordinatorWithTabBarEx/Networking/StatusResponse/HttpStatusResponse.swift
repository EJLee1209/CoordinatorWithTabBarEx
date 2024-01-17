//
//  HttpStatusResponse.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

enum HttpStatusResponse {
    static let ok = 200...299
    static let clientError = 400...499
    static let serverError = 500...599
}
