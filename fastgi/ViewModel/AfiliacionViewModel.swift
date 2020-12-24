//
//  Afiliacion.swift
//  fastgi
//
//  Created by Hegaro on 08/12/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI


class AfiliacionViewModel: ObservableObject {
    @ObservedObject var afiliacionResponse = Afiliacion()
    private var disposables: Set<AnyCancellable> = []
    @Published var isloading: Bool = false
    //@Published var habilitacion: Bool = false
    @Published var afiliacionHabilitacion = AffiliateModel(habilitado: false, _id: "", nombrebanco: "", numerocuenta: "", tiposervicio: "", placa: "", id_usuario: "", fecha: "")
    private var isLoadingPublished: AnyPublisher<Bool, Never> {
        afiliacionResponse.$isloading
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    //DataUser
    private var isAfiliacionPublisher: AnyPublisher<AffiliateModel, Never> {
          afiliacionResponse.$afiliadoResponse
              .receive(on: RunLoop.main)
              .map { response in
                  guard let response = response else {
                    return self.afiliacionHabilitacion
                  }
                  return response
              }
              .eraseToAnyPublisher()
      }
    
    
    init() {
        isLoadingPublished
            .receive(on: RunLoop.main)
            .assign(to: \.isloading, on: self)
            .store(in: &disposables)
        
        isAfiliacionPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.afiliacionHabilitacion, on: self)
            .store(in: &disposables)
        
        verifiAffiliate(id_cobrador: "1231231")
    }
    
    func registerAffiliate(nombrebanco:String, numerocuenta:String, tiposervicio: String, placa: String){
        self.afiliacionResponse.registroAfiliacion(nombrebanco: nombrebanco, numerocuenta: numerocuenta, tiposervicio: tiposervicio, placa: placa)
    }
    
    func verifiAffiliate(id_cobrador:String){
        self.afiliacionResponse.verificaAfiliacion(id_cobrador: id_cobrador)
    }
}
