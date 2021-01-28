//
//  Contacts.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI


class Contacts: ObservableObject {
    
    private let storage = UserDefaults.standard
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    
    var contacts: [Contact] = []
    var contactsVM=ImportContactsViewModel()
    @Published var getContactsResponse:[ContactModel]?
    //update
    var listNumbersApp: [String] = []
    var listNewNumbers: [String] = []
    //lista de contactos nuevos para agregar
    var addContact: [Contact] = []
    //control de update
    @Published var isloading = false
    @Published var messageError :String = ""
    func sendContacts(){
        // print(self.contactsVM.contacts)
        for i in self.contactsVM.contacts {
            print(i.firstName)
            
            
            let parametros : Parameters = [
                "id": storage.string(forKey: idKey)!,
                "nombre": i.firstName,
                "telefono": i.phone ?? "no provided",
                "id_usuario": "234"
            ]
            
            // creando headers
            var headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            
            if let token = storage.string(forKey: tokenKey){
                headers.add(name: "token", value: token)
            }
            
            
            guard let url = URL(string: "https://api.fastgi.com/contactos") else { return }
            DispatchQueue.main.async {
                
                AF.request(url,method:.post,parameters: parametros,headers: headers )
                    // .validate(contentType: ["application/json"])
                    .responseData{response in
                        // debugPrint(response)
                        // print(response)
                        switch response.result {
                        case let .success(data):
                            //Cast respuesta a SmsResponse
                            if let decodedResponse = try? JSONDecoder().decode(CreateContactsResponse.self, from: data) {
                                print(decodedResponse)
                                //debugPrint(decodedResponse.contacto.telefono)
                                
                                return
                            }
                            //Cast respuesta a ErrorResponce
                            if let decodedResponse = try? JSONDecoder().decode(ErrorRecargaResponse.self, from: data) {
                                print(decodedResponse.err.message)
                                //  self.ErrorRes = decodedResponse.err.message
                                return
                            }
                            
                        case let .failure(error):
                            //self.isloading = false
                            print(error)
                        }
                    }
            }
            
        }
        //  print(self.listNewNumbers)
    }
    
    func ListContacts(){
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        //"5f56de014e834e3bc4c02059"
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/contactos/\(idusu)") else { return }
        
        
        DispatchQueue.main.async {
            AF.request(url,method:.get,headers: headers )
                //.validate(contentType: ["application/json"])
                .responseData{response in
                    //debugPrint(response)
                    switch response.result {
                    case let .success(data):
                        //Cast respuesta a MeResponce
                        if let decodedResponse = try? JSONDecoder().decode(ContactsResponse.self, from: data) {
                            // print("get")
                            self.getContactsResponse = decodedResponse.contacto
                            
                            self.getContactsResponse?.forEach({ (contact) in
                                self.listNumbersApp.append(contact.telefono)
                            })
                            return
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
        }
    }
    
    func updateContacts(){
        self.isloading = true
        //get contactos dentro app
        self.ListContacts()
        if self.listNumbersApp.count != 0 {
            for i in self.contactsVM.contacts {
                self.listNewNumbers.append(i.phone!)
            }
            //print(self.listNumbersApp)
            // print(self.listNewNumbers)
            
            //funcion distintos
            let difference = self.listNewNumbers.difference(from: self.listNumbersApp)
            print("este es el difference\(difference)")
            self.isloading = false
            self.messageError = "Se actualizo exitosamente"
            for i in self.contactsVM.contacts {
                for j in difference{
                    if j == i.phone  && difference.count != 0 {
                        // print(i.firstName)
                        
                        //enviando contactos nuevos al servidor
                        let parametros : Parameters = [
                            "id": storage.string(forKey: idKey)!,
                            "nombre": i.firstName,
                            "telefono": i.phone ?? "no provided",
                            "id_usuario": "234"
                        ]
                        // creando headers
                        var headers: HTTPHeaders = [
                            "Accept": "application/json"
                        ]
                        
                        if let token = storage.string(forKey: tokenKey){
                            headers.add(name: "token", value: token)
                        }
                        
                        
                        guard let url = URL(string: "https://api.fastgi.com/contactos") else { return }
                        DispatchQueue.main.async {
                            
                            AF.request(url,method:.post,parameters: parametros,headers: headers )
                                // .validate(contentType: ["application/json"])
                                .responseData{response in
                                    // debugPrint(response)
                                    // print(response)
                                    switch response.result {
                                    case let .success(data):
                                        //Cast respuesta a SmsResponse
                                        if let decodedResponse = try? JSONDecoder().decode(CreateContactsResponse.self, from: data) {
                                            print(decodedResponse)
                                            self.ListContacts()
                                            self.messageError = "Nada que actualizar"
                                            //debugPrint(decodedResponse.contacto.telefono)
                                            self.isloading = false
                                            return
                                        }
                                        //Cast respuesta a ErrorResponce
                                        if let decodedResponse = try? JSONDecoder().decode(ErrorRecargaResponse.self, from: data) {
                                            print(decodedResponse.err.message)
                                            self.messageError = "Se actualizo exitosamente"
                                            //  self.ErrorRes = decodedResponse.err.message
                                            self.isloading = false
                                            return
                                        }
                                        
                                    case let .failure(error):
                                        self.isloading = false
                                        print(error)
                                    }
                                }
                        }
                        
                        //
                    }else{
                        self.isloading = false
                        self.messageError = "Se actualizo exitosamente"
                        
                        //print("el contacto no tiene nombre")
                    }
                }
            }
            
        }else{
            self.isloading = false
            self.messageError = "Se actualizo exitosamente"
      
            print("no hay contactos nuevos")
        }
    }
}



extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
