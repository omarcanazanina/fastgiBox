//
//  RecargaResponse.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct RecargaResponse : Codable {
    let ok : Bool
    let recarga : RecargaModel
}

struct GetRecargasResponse : Codable {
    let ok :Bool
    let recarga: [RecargaModel]
}
struct ErrorRecargaResponse : Codable {
    var ok : Bool
    var err : ErrorRecarga
}
