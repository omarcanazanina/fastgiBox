//
//  RecargaViewModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class RecargaViewModel: ObservableObject {
    @Published var control: String = ""
     var RecargaResponse=Recargas()
    private var disposables: Set<AnyCancellable> = []
    //recarga exitosa
    @Published var recargaData = RecargaModel(_id: "", empresa: "", recarga: "", id_usuario: "", telefono: "", fecha: "")
    // lista de recargas
    @Published var ListRecargas : [RecargaModel] = []
    
    
    private var TestPublished: AnyPublisher<String, Never> {
        RecargaResponse.$control
            .receive(on: RunLoop.main)
            .map { response in
               // print("MVrecarga\(response)")
                return response
        }
        .eraseToAnyPublisher()
    }
    //DataRecarga
    private var RecargaDataPublisher: AnyPublisher<RecargaModel, Never> {
       RecargaResponse.$recargaResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return self.recargaData
                }
                return response
        }
        .eraseToAnyPublisher()
    }
    
      
    
    
}
