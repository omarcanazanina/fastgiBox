//
//  UpdateUserResponse.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//


import Foundation


struct UpdateUserResponse : Codable {
    let ok : Bool
    let usuario : UpdateUserModel
}

struct ErrorUpdateUserResponse : Codable {
    var ok : Bool
    var err : ErrorUpdateUser
}
