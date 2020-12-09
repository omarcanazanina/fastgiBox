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


struct AfiliacionResponse : Codable {
    let ok : Bool
    let afiliacion : AfiliacionModel
}
