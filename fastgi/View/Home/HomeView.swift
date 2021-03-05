//
//  HomeView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import Introspect
//lectorqr
import CodeScanner

struct HomeView: View {
    
    
    @ObservedObject var login = Login()
    @ObservedObject var loginVM = LoginViewModel()
    @Binding var currentBtnEm: BtnEm
    //pagoQR
    @ObservedObject var qrPayment = QrPayment()
    @ObservedObject var qrPaymentVM = QrPaymentViewModel()
    @ObservedObject var userData = UserData()
    @ObservedObject var userDataVM = UserDataViewModel()
    @ObservedObject var contactsVM = ContactsViewModel()
    //lector qr
    @State private var showScannerTeleferico = false
    @State private var showScannerTransporte = false
    @State private var showScannerScan = false
    @State private var resultado = ""
    @State private var resultadosScan = ""
    //lector con monto
    @State private var idconmonto = ""
    @State private var montoQR = ""
    
    @State private var action:Int? = 0

    
    init(currentBtnEm: Binding<BtnEm>) {
        self._currentBtnEm = currentBtnEm
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        //self.contactsVM.getContacts()
        self.userDataVM.DatosUser()
    }
    
    var btnTeleferic:some View{
        Button(action: {
            self.showScannerTeleferico = true
        }){
            VStack{
                Image("Mi_teleferico")
                    .resizable()
                    .frame(width:80, height: 80)
                    .padding(10)
            }
            .background(Color("card"))
            .cornerRadius(10)
            .frame(maxWidth:.infinity)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
        }
        //.background(Color.red.opacity(0.5))
        .sheet(isPresented: self.$showScannerTeleferico) {
            CodeScannerView(codeTypes: [.qr]){ result in
                switch result {
                case .success(let codigo):
                    print("teleferico")
                    self.resultado = codigo
                    self.showScannerTeleferico = false
                    //self.action = 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
                NavigationLink(destination: QrGeneratorView( dataUserlog: self.userDataVM.user), tag: 1, selection: self.$action) {
                    EmptyView()
            }
            }
        }
    }
    
    var btnTransport:some View{
        HStack{
            Button(action: {
                self.showScannerTransporte = true
                self.action = 1
               
            }){
                HStack{
                    Image("Transport")
                        .resizable()
                        .frame(width:80, height: 80)
                        .padding(10)
                }
                .background(Color("card"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
            //.background(Color.blue.opacity(0.5))
            .sheet(isPresented: self.$showScannerTransporte) {
                CodeScannerView(codeTypes: [.qr]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultado = codigo
                        if self.resultado.count > 24 {
                            self.idconmonto = String(self.resultado.prefix(24))
                            print("tiene monto \(self.idconmonto)")
                            self.montoQR = String(self.resultado.dropFirst(24))
                            print("el monto \(self.montoQR)")
                            self.qrPaymentVM.userAfiliacion(id_afiliado: self.idconmonto)
                            self.showScannerTransporte = false
                        }else{
                            print("no tiene monto")
                            self.qrPaymentVM.userAfiliacion(id_afiliado: self.resultado)
                            self.showScannerTransporte = false
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            .onReceive(self.qrPaymentVM.$afiliado) { (afiliado) in
                if afiliado == true {
                    print("entro onreceive")
                    self.userDataVM.DatosUserPago(id_usuario: self.resultado)
                    if self.idconmonto == ""{
                        self.userDataVM.DatosUserPago(id_usuario: self.resultado)
                    }else{
                        self.userDataVM.DatosUserPago(id_usuario: self.idconmonto)
                    }
                  
                }
            }
          
            NavigationLink(destination: PayView(User: self.userDataVM.userResponsePago, montoQR: self.$montoQR), isActive: self.$userDataVM.nextPagoview) {
                EmptyView()
            }
        }
      
    }
    
    var btnScan:some View{
        HStack{
            Button(action: {
                self.showScannerScan = true
                //self.action = 2
               
            }){
                HStack{
                    VStack{
                        Image("Scan")
                            .resizable()
                            .frame(width:50, height: 50)
                            .padding(5)
                            .foregroundColor(Color.white)
                        Text("Scan")
                            .foregroundColor(Color.white)
                    }
                    
                }
                .frame(width:100, height: 100)
                .background(Color("primary"))
                .cornerRadius(10)
                .padding(5)
            }
            //.background(Color.blue.opacity(0.5))
            .sheet(isPresented: self.$showScannerScan) {
                CodeScannerView(codeTypes: [.qr]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultadosScan = codigo
                        self.userDataVM.DatosUserPay(id_usuario: self.resultadosScan)
                        print("aki \(self.userDataVM.userResponsePay)")
                        self.showScannerScan = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }.onReceive(self.userDataVM.$userResponsePay) { (userPay) in
                if userPay._id == "ObjectId"{
                    print("no hay user")
                }else{
                    print("usuario existe")
                  
                }
              
            }
            NavigationLink(destination: ChargeView(dataUserPay: self.userDataVM.userResponsePay), isActive: self.$userDataVM.nextPayview) {
                EmptyView()
            }
        }
    }
    
    var btnPay:some View{
        HStack{
            Button(action: {
                self.action = 4
            }){
                HStack{
                    VStack{
                        Image("Up")
                            .resizable()
                            .frame(width:50, height: 50)
                            .padding(5)
                            .foregroundColor(Color.white)
                        Text("Pagar")
                            .foregroundColor(Color.white)
                    }
                    
                }
                .frame(width:100, height: 100)
                .background(Color("primary"))
                .cornerRadius(10)
                .padding(5)
            }
            NavigationLink(destination: QrChargeView(dataUserlog: self.userDataVM.user), tag: 4, selection: self.$action) {
                EmptyView()
            }
        }
    }
    
    var btnIngresar:some View{
        HStack{
            Button(action: {
                self.action = 3
            }){
                HStack{
                    VStack{
                        Image("Down")
                            .resizable()
                            .frame(width:50, height: 50)
                            .padding(5)
                            .foregroundColor(Color.white)
                        Text("Cobrar")
                            .foregroundColor(Color.white)
                    }
                    
                }
                .frame(width:100, height: 100)
                .background(Color("primary"))
                .cornerRadius(10)
                .padding(5)
            }
            NavigationLink(destination: QrGeneratorView( dataUserlog: self.userDataVM.user), tag: 3, selection: self.$action) {
                EmptyView()
            }
        }
    }
    var home:some View{
        ScrollView{
            VStack{
                HStack(spacing:10){
                    self.btnScan
                    self.btnPay
                    self.btnIngresar
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                VStack{
                    Text("Recarga de línea pre pago")
                        .font(.caption)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.vertical,10)
                    HStack{
                        CardServiceHomeView( logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                        CardServiceHomeView(logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                        CardServiceHomeView(logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                VStack{
                    Text("Transportes")
                        .font(.caption)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.vertical,10)
                    HStack(spacing:10){
                        self.btnTeleferic
                        self.btnTransport
                        Spacer()
                            .frame(maxWidth:.infinity)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                /*VStack{
                 Button(action: {
                 self.action = 6
                 }){
                 Text("prueba")
                 }
                 NavigationLink(destination: TestView(), tag: 6, selection: self.$action) {
                 EmptyView()
                 }
                 
                 }*/
                Button("") {
                    //showingAlert1 = true
                }
                .alert(isPresented: self.$qrPaymentVM.alertNoAfiliado) {
                    Alert(title: Text("Fastgi"), message: Text("Usuario no afiliado."), dismissButton: .cancel())
                }
                
                Button("") {
                    // showingAlert2 = true
                }
                .alert(isPresented: self.$userDataVM.alertInexistente) {
                    Alert(title: Text("Fastgi"), message: Text("Usuario inexistente."), dismissButton: .cancel())
                }
            }
        }
           
        .padding()
       
    }
    
    
    var body: some View {
        VStack{
            self.home
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
            
    }
}
