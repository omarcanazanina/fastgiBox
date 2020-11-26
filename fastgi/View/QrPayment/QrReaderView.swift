//
//  QrReaderView.swift
//  fastgi
//
//  Created by Hegaro on 25/11/2020.
//

import SwiftUI
import CodeScanner

struct QrReaderView: View {
    @State private var showScanner = false
    @State private var resultado = ""
    var body: some View {
        VStack{
            Button(action:{
                self.showScanner = true
            }){
                Text("escanear QR")
            }.sheet(isPresented: self.$showScanner) {
                CodeScannerView(codeTypes: [.qr]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultado = codigo
                        self.showScanner = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            Text(self.resultado)
        }
    }
}

struct QrReaderView_Previews: PreviewProvider {
    static var previews: some View {
        QrReaderView()
    }
}
