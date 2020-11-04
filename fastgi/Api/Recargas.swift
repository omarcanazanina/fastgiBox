//
//  Recargas.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class Recargas: ObservableObject {
    private let storage = UserDefaults.standard
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    @Published var control :String = ""
    @Published var isloading = false
    //DatosRecarga
    @Published var recargaResponse:RecargaModel?
    //Lista recargas
    @Published var getRecargasResponse:GetRecargasResponse?
    
    
    
    func sendRecarga(empresa:BtnEm, recarga:String, telefono:String, text: String){
        let parametros : Parameters = [
            "id": storage.string(forKey: idKey)!,
            "empresa": empresa,
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
        
         
        guard let url = URL(string: "https://api.fastgi.com/recarga") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.post,parameters: parametros,headers: headers )
                // .validate(contentType: ["application/json"])
                .responseData{response in
                    // debugPrint(response)
                    //print(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a SmsResponse
                        if let decodedResponse = try? JSONDecoder().decode(RecargaResponse.self, from: data) {
                            //print(decodedResponse.recarga)
                            self.control = decodedResponse.recarga.empresa
                            self.recargaResponse = decodedResponse.recarga
                            print(self.recargaResponse!)
                            // self.ruta = "idlogin"
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorRecargaResponse.self, from: data) {
                            print(decodedResponse.err.message)
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


     func ListRecargas(){
           // creando headers
           var headers: HTTPHeaders = [
               "Accept": "application/json"
           ]
           if let token = storage.string(forKey: tokenKey){
               headers.add(name: "token", value: token)
           }
           //"5f56de014e834e3bc4c02059"
           let idusu = storage.string(forKey: idKey)!
               guard let url = URL(string: "https://api.fastgi.com/historial/\(idusu)") else { return }
               
               
               DispatchQueue.main.async {
                   AF.request(url,method:.get,headers: headers )
                       //.validate(contentType: ["application/json"])
                       .responseData{response in
                        print(response)
                           switch response.result {
                           case let .success(data):
                               //Cast respuesta a MeResponce
                               if let decodedResponse = try? JSONDecoder().decode(GetRecargasResponse.self, from: data) {
                               // print(decodedResponse.recarga)
                                self.getRecargasResponse=decodedResponse
                                print(self.getRecargasResponse?.recarga as Any)
                                   return
                               }
                           case let .failure(error):
                               print(error)
                           }
                   }
               }
       }
       
    
    
}
