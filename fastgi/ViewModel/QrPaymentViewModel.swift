//
//  QrPaymentViewModel.swift
//  fastgi
//
//  Created by Hegaro on 03/12/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class QrPaymentViewModel: ObservableObject {
    var qrPayResponse=QrPayment()
    private var disposables: Set<AnyCancellable> = []
    @Published var qrPayData = QrPaymentModel(_id: "", monto: "", id_cobrador: "", id_usuario: "", fecha: "")
    //user inextente
    @Published var messageError: String = ""
    @Published var userCorrecto: String = ""
    //nav userafiliacion
    @Published var afiliado : Bool = false
    @Published var noafiliado : String? = ""
    @Published var noafiliadomessage : Bool = false
    //@Published var noafiliadoAlert : String = ""
    private var PagoQrDataPublisher: AnyPublisher<QrPaymentModel, Never> {
        qrPayResponse.$pagoResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return self.qrPayData
                }
                return response
        }
        .eraseToAnyPublisher()
    }
    //usuario inexistente
    private var ErrorPublished: AnyPublisher<String, Never> {
        qrPayResponse.$messageError
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    //usuario inexistente
    private var UserPublished: AnyPublisher<String, Never> {
        qrPayResponse.$userCorrecto
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    //afiliado existe
    private var UserAfiliacionPublished: AnyPublisher<Bool, Never> {
        qrPayResponse.$afiliado
            .receive(on: RunLoop.main)
            .map { response in
                //if response == false {
                    //self.noafiliadoAlert = "noafiliado"
                //}
                self.noafiliadomessage = true
                return response
        }
        .eraseToAnyPublisher()
    }
    
  
    
    
    //afiliado inexistente
    private var UserAfiliacionInexistentePublished: AnyPublisher<String?, Never> {
        qrPayResponse.$noafiliado
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    init() {
        //Datapago
        PagoQrDataPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.qrPayData, on: self)
            .store(in: &disposables)
        
        ErrorPublished
            .receive(on: RunLoop.main)
            .assign(to: \.messageError, on: self)
            .store(in: &disposables)
        
        UserPublished
            .receive(on: RunLoop.main)
            .assign(to: \.userCorrecto, on: self)
            .store(in: &disposables)
        
        UserAfiliacionPublished
            .receive(on: RunLoop.main)
            .assign(to: \.afiliado, on: self)
            .store(in: &disposables)
        
        UserAfiliacionInexistentePublished
            .receive(on: RunLoop.main)
            .assign(to: \.noafiliado, on: self)
            .store(in: &disposables)
        
        //userVerifi(id_cobrador: self.userCorrecto)
    }
    
    func pagoQr(id_cobrador:String, monto:String) {
       // qrPayResponse.pagoQr(id_cobrador: id_cobrador, monto: monto)
        //RecargaResponse.sendRecarga(empresa:empresa, recarga:recarga, telefono: telefono, text:text)
    }
    
    func userVerifi(id_cobrador: String){
        qrPayResponse.verificaUser(id_cobrador: id_cobrador)
    }
    
    func userAfiliacion(id_afiliado: String){
        qrPayResponse.verificaUserAfiliacion(id_afiliado: id_afiliado)
    }
    
}
