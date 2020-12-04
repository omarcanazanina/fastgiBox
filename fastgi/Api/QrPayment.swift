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
    
    func pagoQr(monto:BtnEm, recarga:String, telefono:String, text: String){
        let parametros : Parameters = [
            "id": storage.string(forKey: idKey)!,
            "empresa": monto,
            "recarga":recarga,
            "telefono":telefono
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        
        
        guard let url = URL(string: "https://api.fastgi.com/pago") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a SmsResponse
                        if let decodedResponse = try? JSONDecoder().decode(QrPaymentResponse.self, from: data) {
                            print(decodedResponse.pago)
                            // self.control = decodedResponse.recarga.empresa
                            //self.recargaResponse = decodedResponse.recarga
                            //print(self.recargaResponse!)
                            // self.ruta = "idlogin"
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
