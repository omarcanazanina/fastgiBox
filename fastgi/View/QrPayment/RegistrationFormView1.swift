//
//  RegistrationFormView1.swift
//  fastgi
//
//  Created by Hegaro on 30/11/2020.
//

import SwiftUI

struct RegistrationFormView1: View {
    @State private var name: String = ""
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
    
    var body: some View {
        ScrollView(){
            VStack(alignment: .leading, spacing: 8){
                Text("DATOS PERSONALES")
                    .textStyle(TitleStyle())
                Text("NOMBRE COMPLETO")
                    .textStyle(TitleStyle())
                TextField("Documento de identidad", text: $name)
                    .textFieldStyle(Input())
                Text("DATOS BANCARIOS")
                    .textStyle(TitleStyle())
                Text("BANCO")
                    .textStyle(TitleStyle())
                self.pickerBank
                Text("NRO DE CUENTA")
                    .textStyle(TitleStyle())
                TextField("Correo electronico", text: $name)
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
        }.padding()
    }
}

struct RegistrationFormView1_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationFormView1()
    }
}
