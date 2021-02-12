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
   // @State private var dataUserLog = UpdateUserModel(role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "", apellidos: "", correo: "", direccion: "", nit: "", nombrenit: "", nombres: "", ci: "")
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    
    init(currentBtnEm: Binding<BtnEm>) {
        self._currentBtnEm = currentBtnEm
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        self.contactsVM.getContacts()
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
               /* NavigationLink(destination: QrGeneratorView( dataUserlog: self.dataUserLog), tag: 1, selection: self.$action) {
                    EmptyView()
            }*/
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
                self.action = 2
               
            }){
                HStack{
                    Text("Scan")
                        .frame(width:80, height: 80)
                        .padding(10)
                        .foregroundColor(Color.white)
                }
                .background(Color("primary"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
                
            }
            //.background(Color.blue.opacity(0.5))
            .sheet(isPresented: self.$showScannerScan) {
                CodeScannerView(codeTypes: [.qr]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultadosScan = codigo
                        self.userDataVM.DatosUserPay(id_usuario: self.resultadosScan)
                        //print(<#T##items: Any...##Any#>)
                        self.showScannerScan = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            NavigationLink(destination: ChargeView(dataUserPay: self.userDataVM.userResponsePay), tag: 2, selection: self.$action) {
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
                    Text("Pay")
                        .frame(width:80, height: 80)
                        .padding(10)
                        .foregroundColor(Color.white)
                }
                .background(Color("primary"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
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
                    Text("Cobrar")
                        .frame(width:80, height: 80)
                        .padding(10)
                        .foregroundColor(Color.white)
                }
                .background(Color("primary"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
            }
            NavigationLink(destination: QrGeneratorView( dataUserlog: self.userDataVM.user), tag: 3, selection: self.$action) {
                EmptyView()
            }
        }
    }
    var home:some View{
        ScrollView{
           /* HStack(spacing:10){
                self.btnScan
                self.btnPay
                self.btnIngresar
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)*/
            VStack{
                Text("Recarga de línea pre pago")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack{
                    CardServiceHomeView(contContacts: self.contactsVM.listContacts.count, logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                    CardServiceHomeView(contContacts: self.contactsVM.listContacts.count, logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                    CardServiceHomeView(contContacts: self.contactsVM.listContacts.count, logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
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
                //pruebas
                HStack{
                    if self.userDataVM.isloading == true || self.qrPaymentVM.isloading == true{
                        Loader()
                    }
                    Button(action: {
                        self.action = 3
                    }){
                        //Text("Aceptar")
                    }
                    //NavigationLink(destination: testView(), tag: 3, selection: self.$action) {
                    //    EmptyView()
                   // }
                   // Text(self.resultadosScan)
                }
            
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  
        }
        .padding()
        
    }
    
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Usuario no afiliado."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
    
    var body: some View {
        HStack{
            self.home
        }
        .alert(isPresented:  self.$qrPaymentVM.alertNoAfiliado){
            self.alerts
        }
        }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
            
    }
}
//retorno de cambio de variables ViewModel
/*  .onReceive(self.qrPaymentVM.$noafiliado) {
      if $0 == nil{
          self.alertState = true
      }
  }
  .onReceive(self.qrPaymentVM.$enespera) {
      if $0 == "false"{
          self.alertState = true
      }
  }*/
