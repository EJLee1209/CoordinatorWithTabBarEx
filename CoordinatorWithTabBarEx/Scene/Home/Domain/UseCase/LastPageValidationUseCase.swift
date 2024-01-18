//
//  LastPageValidationUseCase.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//

protocol LastPageValidationUseCase {
    var isLastPage: Bool { get }
    
    mutating func checkAndMoreLoadItems(
        renderedRow: Int,
        itemsCount: Int,
        action: () -> Void
    )
}

struct LastPageValidationUseCaseImpl: LastPageValidationUseCase {
    var isLastPage: Bool = false
    private let threshold = 5
    private let maxItemCount = 300
    
    mutating func checkAndMoreLoadItems(
        renderedRow: Int,
        itemsCount: Int,
        action: () -> Void
    ) {
        
        guard itemsCount < maxItemCount else {
            isLastPage = true
            return
        }
        if itemsCount - threshold == renderedRow {
            action()
        }
    }
}
