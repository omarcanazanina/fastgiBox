//
//  CodeView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//


import SwiftUI

struct CodeView: View {
    @EnvironmentObject private var authState : AuthState
    @ObservedObject var loginVM = LoginViewModel()
    @ObservedObject var login = Login()
    @State var pin: String = ""
    var number: String
    var smstext: String
    var body: some View {
        VStack(spacing:10) {
            /*Text("Verificar código")
                .foregroundColor(.white)
                .padding(.top,60)*/
            
            Image("fastgi_white")
                .resizable()
                .scaledToFit()
                .frame(height:60)
            
            Text("Ingresa el código de verificación")
                .padding(.top)
                .font(.caption)
                .foregroundColor(.white)
            HStack{
                TextField("Código", text: $pin)// $telefono)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                   
            }.accentColor(Color("primary"))
            .padding(12)
            .background(Color.white)
            .clipShape(Capsule())
            .frame(width:220)
            
            Button(action: {
                self.login.loginDetail(telefono: self.number)
            })
            {
                Text("Reenviar SMS")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Button(action: {
                self.loginVM.verificarCode(telefono: self.number, code: self.pin)
                //self.authState.isAuth = true
            })
            {
                Text("Aceptar")
                    .textStyle(TextButtonLoginStyle())
            }
            Text("SMS \(self.smstext)")
            if self.loginVM.isloading == true{
                Loader()
            }else if self.loginVM.messageError != ""{
                Text(self.loginVM.messageError)
                    .foregroundColor(.red)
            }
            Spacer()
            Spacer()
        }
        .padding(.top,60)
        .padding([.leading, .trailing])
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color("primary"))
        .edgesIgnoringSafeArea(.top)
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        CodeView(number: "", smstext: "")
            
            
    }
}
