//
//  UpdateUser.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class UpdateUser{
    private let storage = UserDefaults.standard
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    //recibir localmente
    @Published var userResponse:UpdateUserModel?
    //loading
       @Published var isloading = false
       @Published var iscomplete = false
       //
    
    func updateUser(ci:String, correo:String, nombres:String, apellidos:String, direccion:String, nombrenit:String, nit:String){
          self.isloading = true
        let parametros : Parameters = [
            //"id": storage.string(forKey: idKey)!,
            "ci": ci,
            "correo": correo,
            "nombres": nombres,
            "apellidos": apellidos,
            "direccion": direccion,
            "nombrenit": nombrenit,
            "nit": nit
        ]
        
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/usuario/\(idusu)") else { return }
        DispatchQueue.main.async {
            AF.request(url,method:.put,parameters: parametros,headers: headers )
                .validate(contentType: ["application/json"])
                .responseData{response in
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a MeResponce
                        if let decodedResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data) {
                            print("se modifico")
                            print(decodedResponse.usuario)
                            self.isloading = false
                            self.iscomplete = true
                            return
                        }
                        //Cast respuesta a ErrorResponce
                        if let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            print(decodedResponse.err.message)
                            self.isloading = false
                            self.iscomplete = true
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

