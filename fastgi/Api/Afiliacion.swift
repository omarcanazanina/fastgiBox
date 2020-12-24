//
//  Afiliacion.swift
//  fastgi
//
//  Created by Hegaro on 08/12/2020.
//
import Foundation
import Alamofire
import Combine
import SwiftUI

class Afiliacion: ObservableObject {
    private let storage = UserDefaults.standard
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    @Published var isloading = false
    //@Published var habilitacion = false
    @Published var afiliadoResponse:AffiliateModel?
    func registroAfiliacion(nombrebanco:String, numerocuenta:String, tiposervicio: String, placa: String)   {
        self.isloading = true
        let parametros : Parameters = [
            "nombrebanco": nombrebanco,
            "numerocuenta": numerocuenta,
            "tiposervicio": tiposervicio,
            "placa": placa
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/afiliador/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                 //.validate(contentType: ["application/json"])
                .responseData{response in
                    debugPrint(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a AffiliateResponse
                        if let decodedResponse = try? JSONDecoder().decode(AffiliateResponse.self, from: data) {
                            print("entro a la afiliacion")
                            print(decodedResponse.afiliado)
                            self.isloading = false
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorRecargaResponse.self, from: data) {
                            print(decodedResponse.err.message)
                            self.isloading = false
                            //  self.ErrorRes = decodedResponse.err.message
                            return
                        }
                    case let .failure(error):
                        self.isloading = false
                        print(error)
                    }
                }
        }
        
    }
    
    func verificaAfiliacion(id_cobrador:String)   {
        self.isloading = true
        //print("entro al metodo afiliacion")
        let parametros : Parameters = [
            "id_cobrador": "2131231"
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/afiliado/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                 //.validate(contentType: ["application/json"])
                .responseData{response in
                    //debugPrint(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a AffiliateResponse
                        if let decodedResponse = try? JSONDecoder().decode(AffiliateResponse.self, from: data) {
                            self.afiliadoResponse = decodedResponse.afiliado
                            print("este es la habilitacion \(self.afiliadoResponse)")
                            self.isloading = false
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorRecargaResponse.self, from: data) {
                            print(decodedResponse.err.message)
                            self.isloading = false
                            //  self.ErrorRes = decodedResponse.err.message
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
