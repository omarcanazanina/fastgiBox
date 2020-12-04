//
//  QrPaymentResponse.swift
//  fastgi
//
//  Created by Hegaro on 03/12/2020.
//

import Foundation


struct QrPaymentResponse : Codable {
    let ok : Bool
    let pago : QrPaymentModel
}

struct ErrorQrPaymentResponse : Codable {
    var ok : Bool
    var err : ErrorQrPayment
}
