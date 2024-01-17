//
//  UseDTO.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/17/24.
//

struct UserDTO: Decodable {
    let gender: String
    let name: UserNameDTO
    let picture: PictureDTO
}
