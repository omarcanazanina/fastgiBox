//
//  RegistrationFormView.swift
//  fastgi
//
//  Created by Hegaro on 25/11/2020.
//

import SwiftUI

struct RegistrationFormView: View {
    @State private var name: String = ""
    //select
    var bancos = ["UNION", "FIE", "MERCANTIL", "BNB"]
    var tipos = ["AHORROS", "CORRIENTE"]
    var autos = ["TAXIS", "MICROBUSES"]
       @State private var selectedColor = 0
    
    var body: some View {
        ScrollView(){
            VStack{
                Text("DATOS PERSONALES")
                Text("DOCUMENTO DE IDENTIDAD")
                TextField("Documento de identidad", text: $name)
                Text("CORREO ELECTRONICO")
                TextField("Correo electronico", text: $name)
                Text("NOMBRES")
                TextField("Nombres", text: $name)
                Text("APELLIDOS")
                TextField("Apellidos", text: $name)
                VStack{
                    Text("DIRECCION")
                    TextField("Direccion", text: $name)
                    Text("DATOS BANCARIOS")
                    Text("BANCO")
                    Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                                ForEach(0 ..< bancos.count) {
                                   Text(self.bancos[$0])
                                }
                    }
                    Text("TIPO DE CUENTA")
                    Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                                ForEach(0 ..< tipos.count) {
                                   Text(self.tipos[$0])
                                }
                    }
                    VStack{
                    Text("NUMERO DE CUENTA")
                    TextField("Nro de cuenta", text: $name)
                    Text("TIPO DE SERVICIO")
                    Text("AUTOMOVIL")
                        Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                                    ForEach(0 ..< autos.count) {
                                       Text(self.autos[$0])
                                    }
                        }
                    Text("SINDICATO")
                    TextField("Sindicato", text: $name)
                    Text("NRO DE PLACA")
                    TextField("Nro de placa", text: $name)
                    
                        Button(action: {
                            
                        }){
                            Text("Aceptar")
                        }
                    }
                }
               
               
              
            }
        }
 
    }
}

struct RegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView()
    }
}
