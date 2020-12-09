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
    
    
    func Afiliacion(id_cobrador:String, monto:String)   {
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
        guard let url = URL(string: "https://api.fastgi.com/afiLcion/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                    switch response.result {
                    case let .success(data):
                        if let decodedResponse = try? JSONDecoder().decode(QrPaymentResponse.self, from: data) {
                            //print(decodedResponse.recarga)
                           // self.pagoResponse = decodedResponse.recarga
                            //print(self.pagoResponse!)
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorQrPaymentResponse.self, from: data) {
                            print(decodedResponse.err.message)
                            //  self.ErrorRes = decodedResponse.err.message
                            return
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
        }
        
    }
    
}
