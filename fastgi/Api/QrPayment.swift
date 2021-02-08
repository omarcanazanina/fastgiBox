//
//  QrPayment.swift
//  fastgi
//
//  Created by Hegaro on 03/12/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class QrPayment: ObservableObject {
    private let storage = UserDefaults.standard
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    @Published var pagoResponse: QrPaymentModel?
    
    //nav userafiliacion
    @Published var afiliado : Bool = false
    @Published var noafiliado : String? = ""
    //afiliacion
    @Published var enespera : String = ""
    //loading
    @Published var isloading = false
    func verificaUser(id_cobrador: String){
        let parametros : Parameters = [
            "id_cobrador": id_cobrador
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/transporte/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a SmsResponse
                        if let decodedResponse = try? JSONDecoder().decode(verificaUserResponse.self, from: data) {
                            print("respuesta de la peticion \(decodedResponse.id_cobrador)")
                           // self.userCorrecto = decodedResponse.id_cobrador
                            //print("resp del verifca user akiiiii*** \(self.userCorrecto)")
                           //self.pagoResponse=decodedResponse.usuario
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorVerificaUserResponse.self, from: data) {
                            print("ESTE ES EL ERROR \(decodedResponse)")
                            return
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
        }
        
    }
    
    
    func pagoQr(id_cobrador:String, monto:String){
        let parametros : Parameters = [
            "id_cobrador": id_cobrador,
            "monto": monto
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/transtrans/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                    switch response.result {
                    case let .success(data):
                        if let decodedResponse = try? JSONDecoder().decode(QrPaymentResponse.self, from: data) {
                            //print(decodedResponse.recarga)
                            self.pagoResponse = decodedResponse.recarga
                            print(self.pagoResponse!)
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorQrPaymentResponse.self, from: data) {
                            print("ESTE ES EL ERROR \(decodedResponse.err.message)")
                            //  self.ErrorRes = decodedResponse.err.message
                            return
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
        }
        
    }
    //verifica si esta afiliado
    func verificaUserAfiliacion(id_afiliado: String){
        self.isloading = true
        let parametros : Parameters = [
            "id_afiliado": id_afiliado
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        
        //let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/afiliado/\(id_afiliado)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a SmsResponse
                        if let decodedResponse = try? JSONDecoder().decode(VerificaUserAfiliacionResponse.self, from: data) {
                            print("verifica afiliacion \(decodedResponse.afiliado)")
                            self.afiliado = decodedResponse.afiliado.habilitado
                            print("desde el qrpayment \(self.afiliado)")
                            if decodedResponse.afiliado.habilitado == false {
                                self.enespera = "false"
                            }
                            self.isloading = false
                            //self.userCorrecto = decodedResponse.id_cobrador
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorUserAfiliacionResponse.self, from: data) {
                            print(decodedResponse)
                            self.noafiliado = decodedResponse.afiliado
                            print("usuario no afiliado \(self.noafiliado)")
                            self.isloading = false
                            return
                        }
                    case let .failure(error):
                        self.isloading = false
                        print(error)
                    }
                }
        }
        
    }
    
}
