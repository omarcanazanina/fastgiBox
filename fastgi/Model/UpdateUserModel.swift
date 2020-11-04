//
//  UpdateUserModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct UpdateUserModel : Codable {
    var role: String
    var estado: Bool
    var _id: String
    var telefono: String
    var pin: String
    var fecha:String
    var apellidos:String
    var correo:String
    var direccion:String
    var nit:String
    var nombrenit:String
    var nombres:String
    var ci:String
}
