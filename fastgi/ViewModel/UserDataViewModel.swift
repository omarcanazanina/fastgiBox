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
    
    init(){
        //DataUser
          DataUserPublisher
              .receive(on: RunLoop.main)
              .assign(to: \.user, on: self)
              .store(in: &disposables)
        
        
       DatosUser()
    }
    
    func DatosUser() {
       // if self.control == 0 {
            userDataResponse.DataUser()
        //}
       
      }
    
}
