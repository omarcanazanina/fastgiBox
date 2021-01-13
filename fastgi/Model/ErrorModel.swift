//
//  ErrorModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct ErrorR : Codable {
    var name : String
    var message: String
}
//error al ingresar el code pin sms
struct ErrorSms : Codable {
    //var name : String
    var message: String
}
//error de token recarga
struct ErrorRecarga : Codable{
    var name: String
    var message: String
}

//error de token UpadteUser
struct ErrorUpdateUser : Codable{
    var name: String
    var message: String
}

//error de token pagoqr
struct ErrorQrPayment : Codable{
    var name: String
    var message: String
}

//error verificaUser
struct ErrorVerificaUser : Codable{
    var stringValue: String
    var kind: String
    var value: String
    var path: String
}

