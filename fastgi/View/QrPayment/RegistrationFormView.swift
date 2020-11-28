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
    
    @State var showingSheetBank = false
    @State var bank: String = "Seleccionar"
    var pickerBank: some View{
        Button(action: {
            self.showingSheetBank.toggle()
        }) {
            HStack{
                Text(self.bank)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetBank) {
            ListBankView(
                showingSheet: self.$showingSheetBank,
                bank: self.$bank)
        }
    }
    
    @State var showingSheetAccountType = false
    @State var accountType: String = "Seleccionar"
    var pickerAccountType: some View{
        Button(action: {
            self.showingSheetAccountType.toggle()
        }) {
            HStack{
                Text(self.accountType)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetAccountType) {
            ListAccountTypeView(
                showingSheet: self.$showingSheetAccountType,
                accountType: self.$accountType)
        }
    }
    
    @State var showingSheetTransportType = false
    @State var transportType: String = "Seleccionar"
    var pickerTransportType: some View{
        Button(action: {
            self.showingSheetTransportType.toggle()
        }) {
            HStack{
                Text(self.transportType)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetTransportType) {
            ListTransportTypeView(
                showingSheet: self.$showingSheetTransportType,
                transportType: self.$transportType
            )
        }
    }
    
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
                    self.pickerBank
                    /*Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                        ForEach(0 ..< bancos.count) {
                            Text(self.bancos[$0])
                        }
                    }
                    */
                    Text("TIPO DE CUENTA")
                        .textStyle(TitleStyle())
                    self.pickerAccountType
                    /*Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                        ForEach(0 ..< tipos.count) {
                            Text(self.tipos[$0])
                        }
                    }*/
                    VStack(alignment: .leading, spacing: 8){
                        Text("NUMERO DE CUENTA")
                            .textStyle(TitleStyle())
                        TextField("Nro de cuenta", text: $name)
                            .textFieldStyle(Input())
                        Text("TIPO DE SERVICIO")
                            .textStyle(TitleStyle())
                        Text("AUTOMOVIL")
                            .textStyle(TitleStyle())
                        self.pickerTransportType
                        /*Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                            ForEach(0 ..< autos.count) {
                                Text(self.autos[$0])
                            }
                        }*/
                        
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
