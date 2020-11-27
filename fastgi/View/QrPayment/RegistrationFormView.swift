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
            VStack(alignment: .leading, spacing: 8){
                Text("DATOS PERSONALES")
                    .textStyle(TitleStyle())
                Text("DOCUMENTO DE IDENTIDAD")
                    .textStyle(TitleStyle())
                TextField("Documento de identidad", text: $name)
                    .textFieldStyle(Input())
                Text("CORREO ELECTRONICO")
                    .textStyle(TitleStyle())
                TextField("Correo electronico", text: $name)
                    .textFieldStyle(Input())
                Text("NOMBRES")
                    .textStyle(TitleStyle())
                TextField("Nombres", text: $name)
                    .textFieldStyle(Input())
                Text("APELLIDOS")
                    .textStyle(TitleStyle())
                TextField("Apellidos", text: $name)
                    .textFieldStyle(Input())
                VStack(alignment: .leading, spacing: 8){
                    Text("DIRECCION")
                        .textStyle(TitleStyle())
                    TextField("Direccion", text: $name)
                        .textFieldStyle(Input())
                    Text("DATOS BANCARIOS")
                        .textStyle(TitleStyle())
                    Text("BANCO")
                        .textStyle(TitleStyle())
                    Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                        ForEach(0 ..< bancos.count) {
                            Text(self.bancos[$0])
                        }
                    }
                    Text("TIPO DE CUENTA")
                        .textStyle(TitleStyle())
                    Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                        ForEach(0 ..< tipos.count) {
                            Text(self.tipos[$0])
                        }
                    }
                    VStack(alignment: .leading, spacing: 8){
                        Text("NUMERO DE CUENTA")
                            .textStyle(TitleStyle())
                        TextField("Nro de cuenta", text: $name)
                            .textFieldStyle(Input())
                        Text("TIPO DE SERVICIO")
                            .textStyle(TitleStyle())
                        Text("AUTOMOVIL")
                            .textStyle(TitleStyle())
                        Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                            ForEach(0 ..< autos.count) {
                                Text(self.autos[$0])
                            }
                        }
                        
                        Text("SINDICATO")
                            .textStyle(TitleStyle())
                        TextField("Sindicato", text: $name)
                            .textFieldStyle(Input())
                        Text("NRO DE PLACA")
                            .textStyle(TitleStyle())
                        TextField("Nro de placa", text: $name)
                            .textFieldStyle(Input())
                        Button(action: {
                            
                        }){
                            Text("Aceptar")
                                .foregroundColor(Color.white)
                                .frame(maxWidth:.infinity)
                                .padding(8)
                                .background(Color("primary"))
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                        }
                    }
                }
                
                
                
            }
        }.padding()
        
    }
}

struct RegistrationFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView()
    }
}
