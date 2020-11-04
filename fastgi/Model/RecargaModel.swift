//
//  RecargaModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct RecargaModel : Codable { //,Identifiable {
    let _id : String
    let empresa : String
    let recarga : String
    let id_usuario : String
    let telefono : String
    let fecha : String
}
