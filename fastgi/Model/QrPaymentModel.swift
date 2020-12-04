//
//  QrPaymentModel.swift
//  fastgi
//
//  Created by Hegaro on 03/12/2020.
//

import Foundation

struct QrPaymentModel : Codable { //,Identifiable {
    let _id : String
    let id_usuario : String
    let id_cobrador : String
    let fecha : String
}
