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
    
    init() {
        //Datapago
        PagoQrDataPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.qrPayData, on: self)
            .store(in: &disposables)
    }
    
    func pagoQr(id_cobrador:String, monto:String) {
        qrPayResponse.pagoQr(id_cobrador: id_cobrador, monto: monto)
        //RecargaResponse.sendRecarga(empresa:empresa, recarga:recarga, telefono: telefono, text:text)
    }
    
}
