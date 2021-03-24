//
//  QrPaymentResponse.swift
//  fastgi
//
//  Created by Hegaro on 03/12/2020.
//

import Foundation


struct QrPaymentResponse : Codable {
    let ok : Bool
    let recarga : QrPaymentModel
}

struct ErrorQrPaymentResponse : Codable {
    var ok : Bool
    var err : ErrorQrPayment
}

//verifica afiliado
struct VerificaUserAfiliacionResponse : Codable {
    let ok : Bool
    let afiliado : VerificaUserAfiliadoModel
}

// error afiliacion user
struct ErrorUserAfiliacionResponse : Codable {
    var ok : Bool
    var afiliado : String?
}

// verifica user
struct verificaUserResponse : Codable {
    var ok : Bool
    var id_cobrador : String
}

// verifica user
struct ErrorVerificaUserResponse : Codable {
    var ok : Bool
    var err : ErrorVerificaUser
}

struct GetPagosResponse : Codable {
    let ok :Bool
    let recarga: [QrPaymentModel]
}
