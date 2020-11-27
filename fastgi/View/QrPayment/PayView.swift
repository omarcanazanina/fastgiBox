//
//  PayView.swift
//  fastgi
//
//  Created by Hegaro on 26/11/2020.
//

import SwiftUI

struct PayView: View {
    @State private var test: String = ""
    var monto: String
    var body: some View {
        VStack{
            Text("Ingresamos el monto")
            Text(self.monto)
            Text("MONTO BS.")
            TextField("Ingrese monto", text: $test)
        }
        
    }
}

struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(monto: "")
    }
}
