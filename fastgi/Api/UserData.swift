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
   // @Published var userResponse:UpdateUserModel?
    @Published var user:UserModel?
    @Published var user1:UpdateUserModel?
    @Published var userResponsePago:UpdateUserPagoModel?
    @Published var userResponsePay:UpdateUserPagoModel?
    @Published var messageError :String = ""
    @Published var alertInexistente :Bool = false
    //rutas
    var navigationRoot = NavigationRoot()
    
    //loading
    @Published var isloading = false
    
    func DataUser(){
            // creando headers
            var headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            if let token = storage.string(forKey: tokenKey){
                headers.add(name: "token", value: token)
                print("token: \(token)")
            }
           // print("este es el id storage \(storage.string(forKey: idKey)!)")
            if storage.string(forKey: idKey) == nil {
                print("USUARIO NO EXISTENTE")
            }
            else {
                let idusu = storage.string(forKey: idKey)!
                //let nombreusu = storage.string(forKey: nombrekey)
                guard let url = URL(string: "https://api2.fastgi.com/usuario/\(idusu)") else { return }
                DispatchQueue.main.async {
                    AF.request(url,method:.get,headers: headers )
                        //.validate(contentType: ["application/json"])
                        .responseData{response in
                            // debugPrint(response)
                            switch response.result {
                            case let .success(data):
                                //Cast respuesta a MeResponce
                                if let decodedResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
                                    print(decodedResponse.usuario)
                                    //self.testid = idusu
                                    //print("nombre del storage \(nombreusu)")
                                    self.user=decodedResponse.usuario
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
            }
     //   let idusu = "5fdc92d1aba3aa37fb913e6d"
        //print("este es el id storage \(idusu)")
    
    func DataUser1(){
           // creando headers
           var headers: HTTPHeaders = [
               "Accept": "application/json"
           ]
           if let token = storage.string(forKey: tokenKey){
               headers.add(name: "token", value: token)
           }
          // print("este es el id storage \(storage.string(forKey: idKey)!)")
           if storage.string(forKey: idKey) == nil {
               print("USUARIO NO EXISTENTE")
           }
           else {
               let idusu = storage.string(forKey: idKey)!
               //let nombreusu = storage.string(forKey: nombrekey)
               guard let url = URL(string: "https://api2.fastgi.com/usuario/\(idusu)") else { return }
               DispatchQueue.main.async {
                   AF.request(url,method:.get,headers: headers )
                       //.validate(contentType: ["application/json"])
                       .responseData{response in
                           // debugPrint(response)
                           switch response.result {
                           case let .success(data):
                               //Cast respuesta a MeResponce
                               if let decodedResponse = try? JSONDecoder().decode(DataUserResponse.self, from: data) {
                                   //print(decodedResponse.usuario)
                                 //  self.testid = idusu
                                   //print("nombre del storage \(nombreusu)")
                                   self.user1=decodedResponse.usuario
                                   //self.user1tel=decodedResponse.usuario.telefono
                                   //print("user1 log \(self.user1tel)")
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
           }
       
   
    
    
    func DataUserPago(id_usuario: String){
        self.isloading = true
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
                            print("este es el user\(self.userResponsePago!)")
                            self.isloading = false
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorResponsePago.self, from: data) {
                            print(decodedResponse.err.kind)
                            self.messageError = decodedResponse.err.kind
                            self.isloading = false
                            /*if decodedResponse1.err.name == "TokenExpiredError" || decodedResponse1.err.name == "JsonWebTokenError"{
                               // self.navigationRoot.changeRootClose()
                            }*/
                            return
                        }
                    case let .failure(error):
                        self.isloading = false
                        print(error)
                    }
                }
        }
    }
    
    func DataUserPay(id_usuario: String){
        self.isloading = true
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
                            self.userResponsePay = decodedResponse.usuario
                            print("este es el userPay\(self.userResponsePay!)")
                            self.isloading = false
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorResponsePago.self, from: data) {
                            print(decodedResponse.err.kind)
                            self.messageError = decodedResponse.err.kind
                            self.alertInexistente = true
                            self.isloading = false
                            /*if decodedResponse1.err.name == "TokenExpiredError" || decodedResponse1.err.name == "JsonWebTokenError"{
                               // self.navigationRoot.changeRootClose()
                            }*/
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


