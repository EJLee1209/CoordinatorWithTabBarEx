//
//  Gender.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

enum Gender: String {
    case male
    case female
    case unknowned
}

extension Gender: CustomStringConvertible {
    var description: String {
        switch self {
        case .male:
            return "Gender: 🚹"
        case .female:
            return "Gender: 🚺"
        default:
            return "Gender: ❓"
        }
    }
}
