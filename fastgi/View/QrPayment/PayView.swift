//
//  PayView.swift
//  fastgi
//
//  Created by Hegaro on 26/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct PayView: View {
    @State private var monto: String = ""
    var user: UpdateUserPagoModel
    //var dataUser: String
    @Binding var montoQR : String
    //test
    @ObservedObject var qrPayment = QrPayment()
    @ObservedObject var qrPaymentVM = QrPaymentViewModel()
    @ObservedObject var userDataVM = UserDataViewModel()
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    
    @State private var action:Int? = 0
    
    init(User:UpdateUserPagoModel  ,montoQR: Binding<String>) {
        self.user = User
        self._montoQR = montoQR
        self.userDataVM.DatosUser()
    }
    var imageProfile:some View {
        HStack(alignment: .center){
                WebImage(url: URL(string: "https://i.postimg.cc/8kJ4bSVQ/image.jpg" ))
                    .onSuccess { image, data, cacheType in
                    }
                    .placeholder(Image( "user-default"))
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100.0, height: 100.0)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .overlay(
                        Circle()
                            .stroke(Color("card"), lineWidth: 2))
            
        }
        
    }
    
    
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
               /* if self.user != "" {
                    self.qrPaymentVM.userAfiliacion(id_afiliado: self.user)
                    self.userDataVM.DatosUserPago(id_usuario: self.user)
                }else if self.user == "" {
                    print("no hay user afiliado")
                }
                if  self.qrPaymentVM.noafiliado == nil {
                    self.alertState = true
                }*/
                
                //
                self.qrPaymentVM.pagoQr(id_cobrador: self.user._id, monto: self.monto)
                self.action = 1
            }){
                Text("Pagar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
           /* NavigationLink(destination: TestpayDetail(monto: self.monto, nombreCobrador: self.user, id_usuario: self.qrPaymentVM.qrPayData.id_usuario), tag: 1, selection: self.$action) {
                EmptyView()
        }*/
            if self.montoQR == "" {
                NavigationLink(destination: TestpayDetail(monto: self.monto, nombreCobrador: "\(self.user.nombres) \(self.user.apellidos)", fecha: "", nombreUser: "\(self.userDataVM.user.nombres ?? "") \(self.userDataVM.user.apellidos ?? "")",fechaFormat: "", horaFormat: ""), tag: 1, selection: self.$action) {
                     EmptyView()
             }
            }else{
                NavigationLink(destination: TestpayDetail(monto: self.montoQR, nombreCobrador: "\(self.user.nombres) \(self.user.apellidos)", fecha: "", nombreUser: "\(self.userDataVM.user.nombres ?? "") \(self.userDataVM.user.apellidos ?? "")",fechaFormat: "", horaFormat: ""), tag: 1, selection: self.$action) {
                     EmptyView()
             }
            }
         
        }
        .padding()
    }
    
    
    var body: some View {
        //NavigationView{
            VStack{
                Text("Pagar transporte")
                    .font(.title)
                self.imageProfile
                if self.user.nombres == Optional(""){
                    Text("+591 \(self.user.telefono)")
                }else{
                    Text("\(self.user.nombres) \(self.user.apellidos)")
                }
                VStack(alignment: .leading, spacing: 8){
                    Text("MONTO BS.")
                        .textStyle(TitleStyle())
                    if self.montoQR == "" {
                        TextField("Ingrese monto", text: $monto)
                            .textFieldStyle(Input())
                            .keyboardType(.decimalPad)
                            .introspectTextField { (textField) in
                                let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                             doneButton.tintColor = .darkGray
                                toolBar.items = [flexButton, doneButton]
                                toolBar.setItems([flexButton, doneButton], animated: true)
                                textField.inputAccessoryView = toolBar
                                //textField.becomeFirstResponder()
                             }
                    }else{
                        TextField("Ingrese monto", text: $montoQR )
                            .textFieldStyle(Input())
                            .keyboardType(.decimalPad)
                            .introspectTextField { (textField) in
                                let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                             doneButton.tintColor = .darkGray
                                toolBar.items = [flexButton, doneButton]
                                toolBar.setItems([flexButton, doneButton], animated: true)
                                textField.inputAccessoryView = toolBar
                               // textField.becomeFirstResponder()
                             }
                    }
                    
                }
                self.buttonSuccess
                HStack{
                   /* Button(action: {
                        if self.user != "" {
                            self.qrPaymentVM.userAfiliacion(id_afiliado: self.user)
                            self.userDataVM.DatosUserPago(id_usuario: self.user)
                        }else if self.user == "" {
                            print("no hay user afiliado")
                        }
                        if  self.qrPaymentVM.noafiliado == nil {
                            self.alertState = true
                        }
                    }){
                        Text("Aceptar")
                    }*/
                  /*  if self.qrPaymentVM.afiliado == true {
                        Text("user existente")
                    }
                    if  self.qrPaymentVM.noafiliado == nil {
                        
                        Text("User no esta afiliado")
                            .foregroundColor(.red)
                        //self.alertState = true
                    }*/
                }
            }
            .padding(.horizontal)
    //}
            .alert(isPresented:  self.$alertState){
                self.alerts
            }
    //.navigationBarTitle("Pagar transporte", displayMode: .inline)
}
    //alerta
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Usuario no afiliado."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
    
}

/*struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(user: UpdateUserPagoModel, resultado: "")
    }
}*/
