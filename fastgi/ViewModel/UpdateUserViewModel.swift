//
//  UpdateUserViewModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI
import ValidatedPropertyKit

class UpdateUserViewModel: ObservableObject {
    //validation
    @Published private(set) var brokenRules = [BrokenRule]()
    @Validated(.required(errorMessage:"Por favor ingrese su num") && .range(8...8))
    var ci:String? = ""
    @Validated(.required(errorMessage:"Correo vacio"))
    var correo:String? = ""
   @Validated(.required(errorMessage:"Nombres vacios"))
    var nombres:String? = ""
   @Validated(.required(errorMessage:"Apellidos vacios"))
    var apellidos:String? = ""
    @Validated(.required(errorMessage:"Dirección vacio"))
    var direccion:String? = ""
    @Validated(.required(errorMessage:"Nombre Nit vacio"))
    var nombrenit:String? = ""
    @Validated(.required(errorMessage:"Nit vacio"))
    var nit:String? = ""
     //recuperar datos de user
    var loginResponse=Login()
    @Published var userDataUpdate = UpdateUserModel(role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "", apellidos: "", correo: "", direccion: "", nit: "", nombrenit: "", nombres: "", ci: "")
    //@Published var userDataUpdate = UpdateUserModel(role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "", apellidos: "", correo: "", direccion: "", nit: "", nombrenit: "", nombres: "", ci: "",img: "")
   
    var UpdateUserResponse = UpdateUser()
    private var disposables: Set<AnyCancellable> = []
    @Published var isloading: Bool = false
    
    private var isLoadingPublished: AnyPublisher<Bool, Never> {
        UpdateUserResponse.$isloading
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    private var DataUserPublisher: AnyPublisher<UpdateUserModel, Never> {
            loginResponse.$userResponse
                .receive(on: RunLoop.main)
                .map { response in
                    guard let response = response else {
                        return self.userDataUpdate
                    }
                    return response
                }
                .eraseToAnyPublisher()
        }
    
    init(){
        
        isLoadingPublished
            .receive(on: RunLoop.main)
            .assign(to: \.isloading, on: self)
            .store(in: &disposables)
        
        //DataUser
            DataUserPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.userDataUpdate, on: self)
                .store(in: &disposables)
        
    }
    
    
    /*func updateUser() {
        let contentTypes=["role","estado","_id","telefono","pin","fecha","","","","","",""]
    }*/
    
    func DatosUserUpdate() {
        loginResponse.DataUser()
         }
    
    func updateUser(ci: String, correo: String, nombres: String, apellidos: String, direccion: String, nombrenit: String, nit: String)  {
        UpdateUserResponse.updateUser(ci: ci, correo: correo, nombres: nombres, apellidos: apellidos, direccion: direccion, nombrenit: nombrenit, nit: nit)
    }
    
    func validationInput()  {
          if self.validate() {
              
          }
      }
      
      private func validate() -> Bool {
          self.brokenRules.removeAll()
          
          let rules = [
          "Ci": _ci.validationError,
          "Correo": _correo.validationError,
          "Nombres": _nombres.validationError,
          "Apellidos": _apellidos.validationError,
          "Direccion": _direccion.validationError,
          "NombreNit": _nombrenit.validationError,
          "Nit": _nit.validationError,
          ]
          print(rules)
          _ = rules.compactMap{ pair in
              guard let errormessage = pair.1?.failureReason else {
                  return
              }
              self.brokenRules.append(BrokenRule(propertyName: pair.0, message: "\(errormessage)"))
          }
          return self.brokenRules.count == 0
      }
    
}
