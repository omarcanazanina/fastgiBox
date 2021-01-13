//
//  QrPaymentModel.swift
//  fastgi
//
//  Created by Hegaro on 03/12/2020.
//

import Foundation

struct QrPaymentModel : Codable { //,Identifiable {
    let _id : String
    let monto : String
    let id_cobrador : String
    let id_usuario : String
    let fecha : String
}

struct VerificaUserModel : Codable { //,Identifiable {
    let _id : String
    let id_usuario : String
    let id_cobrador : String
    let fecha : String
}

struct VerificaUserAfiliadoModel : Codable { //,Identifiable {
    let habilitado : Bool
    let _id : String
    let nombrebanco : String
    let numerocuenta : String
    let tiposervicio : String
    let placa : String
    let id_usuario : String
    let fecha : String
}
