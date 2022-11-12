//
//  UserDTO.swift
//  STGv2
//
//  Created by Daniil Savva on 28.10.2022.
//

struct UserLoginDTO {
    var username: String
    var password: String
}

struct UserRegistrationDTO {
    var username: String
    var password: String
}

struct UserForgetDTO {
    var step: Int
    var username: String
    var forget_id: Int
    var code: String
}

struct UserProfileEditDTO {
    var username: String
    var passwordNew: String
    var passwordCurrent: String
}
