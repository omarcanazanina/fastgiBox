//
//  CodeView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//


import SwiftUI
import Introspect

struct CodeView: View {
    @EnvironmentObject private var authState : AuthState
    @ObservedObject var loginVM = LoginViewModel()
    @ObservedObject var login = Login()
    @State var pin: String = ""
    var number: String
    var smstext: String
    //contador de intentos
    @State var contIntentos: Int = 0
    
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    @State var alertStateTemp: Bool = false
    
    //temporizador
    @State var timeRemaining = 15
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                    .keyboardType(.numberPad)
                    .padding(12)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .frame(width:220)
                    .introspectTextField { (textField) in
                        textField.becomeFirstResponder()
                     }
                   
            }
           /* .accentColor(Color("primary"))
            .padding(12)
            .background(Color.white)
            //.clipShape(Capsule())
            .frame(width:220)*/
            
            Text("Nro de intentos \(self.contIntentos)")
            //temporizador
            Text("tiempo espera de sms \(timeRemaining)")
                        .onReceive(timer) { _ in
                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 1
                            }
                        }
            
            Button(action: {
                if self.timeRemaining == 0 {
                    self.login.loginDetail(telefono: self.number)
                }else{
                    print("Espere q el tiempo termine")
                    self.alertStateTemp = true
                }
                
            })
            {
                Text("Reenviar SMS")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            
            Button(action: {
                self.contIntentos += 1
                if self.contIntentos <= 3 {
                    self.loginVM.verificarCode(telefono: self.number, code: self.pin)
                }else if self.contIntentos >= 4 {
                    self.alertState = true
                }
                
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
            //Spacer()
        }
        .padding(.top,60)
        .padding([.leading, .trailing])
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color("primary"))
        .edgesIgnoringSafeArea(.top)
        
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
        .alert(isPresented:  self.$alertStateTemp){
            self.alertTemp
        }
    }
    
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Intente mas tarde por favor."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
   
    var alertTemp:Alert{
        Alert(title: Text("Fastgi"), message: Text("Espere que termine el tiempo por favor."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        CodeView(number: "", smstext: "")
            
            
    }
}
