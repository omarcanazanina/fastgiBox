//
//  Test2View.swift
//  fastgi wallet
//
//  Created by Hegaro on 26/03/2021.
//

import SwiftUI

struct Test2View: View {
   @ObservedObject var validationVM = ValidationViewModel()
   @ObservedObject var userDataVM = UserDataViewModel()
    init(){
        self.userDataVM.DatosUser()
    }
    var body: some View {
        //EntryField(sfSymbolName: "envelope", placeHolder: "Ci", prompt: validationVM.ciPrompt, field: $validationVM.ci)
        EntryField(sfSymbolName: "envelope", placeHolder: "Nombre", prompt: validationVM.namePrompt, field: $validationVM.name)//.constant(self.userDataVM.user.nombres ?? ""))
        EntryField(sfSymbolName: "envelope", placeHolder: "Email Address", prompt: validationVM.emailPrompt, field: $validationVM.email)
        EntryField(sfSymbolName: "envelope", placeHolder: "Apellidos", prompt: validationVM.apellidosPrompt, field: $validationVM.apellidos)
        EntryField(sfSymbolName: "envelope", placeHolder: "Direccion", prompt: validationVM.direccionPrompt, field: $validationVM.direccion)
        EntryField(sfSymbolName: "envelope", placeHolder: "Nombre Nit", prompt: validationVM.nameNitPrompt, field: $validationVM.nombrenit)
       /* EntryField(sfSymbolName: "lock", placeHolder: "Password", prompt: validationVM.passwordPrompt, field: $validationVM.password, isSecure: true)
        EntryField(sfSymbolName: "lock", placeHolder: "Confirm", prompt: validationVM.confirmPwPrompt, field: $validationVM.confirmPw, isSecure: true)*/
        Button(action:{
            
        }){
            Text("Test")
        }
        .opacity(validationVM.isValidationComplete ? 1 : 0.6)
        .disabled(!validationVM.isValidationComplete)
    }
}

struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}

struct EntryField: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: String
    var isSecure:Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                if isSecure {
                    SecureField(placeHolder, text: $field).autocapitalization(.none)
                } else {
                    
                    TextField(placeHolder, text: $field).autocapitalization(.none)
                }
            }
            .padding(8)
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}


