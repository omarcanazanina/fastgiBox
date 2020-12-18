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
    @Published var messageError :String = ""
    @Published var userCorrecto :String = ""
    @Published var pagoResponse: QrPaymentModel?
    
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
                           // print("respuesta de la peticion \(decodedResponse.id_cobrador)")
                            self.userCorrecto = decodedResponse.id_cobrador
                            print("resp del verifca user akiiiii*** \(self.userCorrecto)")
                           //self.pagoResponse=decodedResponse.usuario
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorVerificaUserResponse.self, from: data) {
                            //print("ESTE ES EL ERROR \(decodedResponse.err.kind)")
                            self.messageError = decodedResponse.err.kind
                            print("EL ERROR ES \(self.messageError)")
                            //  self.ErrorRes = decodedResponse.err.message
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
    
    func pagoQr1(id_cobrador:String, monto:String){
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
       func liat(id_cobrador:String, monto:String){
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
    
  /*  func ListPagoz(){
          // creando headers
          var headers: HTTPHeaders = [
              "Accept": "application/json"
          ]
          if let token = storage.string(forKey: tokenKey){
              headers.add(name: "token", value: token)
          }
          //"5f56de014e834e3bc4c02059"
          let idusu = storage.string(forKey: idKey)!
              guard let url = URL(string: "https://api.fastgi.com/pagos/\(idusu)") else { return }
       //print("este es el idusuariolist recargas\(idusu)")
              DispatchQueue.main.async {
                  AF.request(url,method:.get,headers: headers )
                      //.validate(contentType: ["application/json"])
                      .responseData{response in
                       //debugPrint(response)
                          switch response.result {
                          case let .success(data):
                              //Cast respuesta a MeResponce
                              if let decodedResponse = try? JSONDecoder().decode(GetRecargasResponse.self, from: data) {
                              // print(decodedResponse.recarga)
//                               self.getRecargasResponse=decodedResponse
  //                             print(self.getRecargasResponse?.recarga ?? "")
                                  return
                              }
                          case let .failure(error):
                              print(error)
                          }
                  }
              }
      }*/
    
}
