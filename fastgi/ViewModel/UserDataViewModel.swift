//
//  UserDataViewModel.swift
//  fastgi
//
//  Created by Hegaro on 02/12/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class UserDataViewModel: ObservableObject {
    var userDataResponse=UserData()
    //datos del usuario
    @Published var user = UpdateUserModel(role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "", apellidos: "", correo: "", direccion: "", nit: "", nombrenit: "", nombres: "", ci: "")
    //datos del usuario pago
    @Published var userPago = UpdateUserPagoModel(img: "", role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "", apellidos: "", correo: "", direccion: "", nit: "", nombrenit: "", nombres: "")
    
    private var disposables: Set<AnyCancellable> = []
    
    //DataUser
    private var DataUserPublisher: AnyPublisher<UpdateUserModel, Never> {
          userDataResponse.$userResponse
              .receive(on: RunLoop.main)
              .map { response in
                  guard let response = response else {
                    return self.user
                  }
                  return response
              }
              .eraseToAnyPublisher()
      }
    
    //DataUser
    private var DataUserPagoPublisher: AnyPublisher<UpdateUserPagoModel, Never> {
          userDataResponse.$userResponsePago
              .receive(on: RunLoop.main)
              .map { response in
                  guard let response = response else {
                    return self.userPago
                  }
                  return response
              }
              .eraseToAnyPublisher()
      }
    
    init(){
        //DataUser
          DataUserPublisher
              .receive(on: RunLoop.main)
              .assign(to: \.user, on: self)
              .store(in: &disposables)
        
        //DataUser
          DataUserPagoPublisher
              .receive(on: RunLoop.main)
              .assign(to: \.userPago, on: self)
              .store(in: &disposables)
        
       DatosUser()
    }
    
    func DatosUser() {
            userDataResponse.DataUser()
      }
    
    func DatosUserPago(id_usuario: String) {
            userDataResponse.DataUserPago(id_usuario: id_usuario)
      }
}
