//
//  UserData.swift
//  fastgi
//
//  Created by Hegaro on 02/12/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI
import SDWebImageSwiftUI

class UserData: ObservableObject {
    //Storage
    private let storage = UserDefaults.standard
    
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    //datauser
    @Published var userResponse:UpdateUserModel?
    @Published var userResponsePago:UpdateUserPagoModel?
    //rutas
    var navigationRoot = NavigationRoot()
    
    func DataUser(){
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/usuario/\(idusu)") else { return }
        //print("este es el idusuario\(idusu)")
        DispatchQueue.main.async {
            AF.request(url,method:.get,headers: headers )
                //.validate(contentType: ["application/json"])
                .responseData{response in
                    // debugPrint(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a MeResponce
                        if let decodedResponse = try? JSONDecoder().decode(DataUserResponse.self, from: data) {
                            print(decodedResponse.usuario)
                            self.userResponse=decodedResponse.usuario
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            //print(decodedResponse.err.name)
                            if decodedResponse.err.name == "TokenExpiredError" || decodedResponse.err.name == "JsonWebTokenError"{
                                self.navigationRoot.changeRootClose()
                            }
                            return
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
        }
    }
    
    
    func DataUserPago(id_usuario: String){
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        //let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/usuario/\(id_usuario)") else { return }
        //print("este es el idusuario\(idusu)")
        DispatchQueue.main.async {
            AF.request(url,method:.get,headers: headers )
                //.validate(contentType: ["application/json"])
                .responseData{response in
                    // debugPrint(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a MeResponce
                        if let decodedResponse = try? JSONDecoder().decode(DataUserPagoResponse.self, from: data) {
                            //print(decodedResponse1.usuario)
                            self.userResponsePago = decodedResponse.usuario
                            print("este es el user\(self.userResponsePago as Any)")
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            print(decodedResponse.err.name)
                            /*if decodedResponse1.err.name == "TokenExpiredError" || decodedResponse1.err.name == "JsonWebTokenError"{
                               // self.navigationRoot.changeRootClose()
                            }*/
                            return
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
        }
    }
    
    
}


