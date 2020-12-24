//
//  LoginView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    
    @State var showingSheet = false
    @State var code: String = "+591"
    @State var phone: String = ""
    @State var country: String = "Bolivia"
    
    @ObservedObject var login = Login()
    @State var telefono: String = ""
    
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing:10) {
                Text("Fastgi")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top)
                //Text("este es el sms \(self.loginVM.smstext)")
                //Text("este es el sms \(self.loginVM.pin.pin)")
                Text("Te enviaremos un sms con el código de verificación")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                /*Button select codes*/
                Button(action: {
                    self.showingSheet.toggle()
                }) {
                    HStack{
                        
                        Text(self.country)
                            .foregroundColor(.white)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }.sheet(isPresented: $showingSheet) {
                    ListAreaCodeView(
                        showingSheet: self.$showingSheet,
                        code: self.$code,
                        country: self.$country)
                }
                HStack{
                    TextField("Código", text: $code)
                        .padding(12)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .keyboardType(.namePhonePad)
                        .frame(maxWidth:120)
                        .clipShape(Capsule())
                    
                    TextField("Teléfono", text: self.$loginVM.telefono.bound)
                        .keyboardType(.numberPad)
                        .padding(12)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                         doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                         }
                }
            
                BrokenRulesView(brokenRules: self.loginVM.brokenRules)
                
                Button(action: {
                    self.loginVM.validationInput()
                    self.login.loginDetail(telefono: self.loginVM.telefono.bound)
                })
                {
                    Text("Ingresar")
                        .textStyle(TextButtonLoginStyle())
                }
                Spacer()
               // Text("SMS \(self.loginVM.pin.pin)")
                NavigationLink(destination: CodeView(number: self.loginVM.telefono.bound, smstext: self.loginVM.smstext), tag: "idlogin", selection: self.$login.ruta) {
                    EmptyView()
                }
                
            }
        
            .padding([.top, .leading, .trailing])
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(Color("primary"))
            .edgesIgnoringSafeArea(.top)
        }.accentColor(.white)
        
    }
    
 
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

