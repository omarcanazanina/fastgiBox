//
//  SmsResponse.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//
import Foundation

struct SmsResponse: Codable {
    var ok :Bool
    var usuario : Usuario
    
}

struct ErrorResponse:Codable {
    var ok : Bool
    var err : ErrorR
}
//error ingreso code pin sms

struct ErrorSmsResponse:Codable {
    var ok : Bool
    var err : ErrorSms
}
struct ErrorResponsePago:Codable {
    var ok : Bool
    var err : ErrorVerificaUser
}

struct LoginSmsResponse:Codable {
    var ok :Bool
    var usuario : Usuario
    var token : String
}
