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
    //
    @State var text = ""
    //lector qr
    @State private var showScannerTeleferico = false
    @State private var showScannerTransporte = false
    @State private var resultado = ""
    //lector con monto
    @State private var idconmonto = ""
    @State private var montoQR = ""
    
    @State private var action:Int? = 0
    //test
    @ObservedObject var qrPayment = QrPayment()
    @ObservedObject var qrPaymentVM = QrPaymentViewModel()
    @ObservedObject var userData = UserData()
    @ObservedObject var userDataVM = UserDataViewModel()
    @State var test = ""
    
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    
    
    // fecha prueba
    let string = "2021-01-18T21:53:57.977Z"
    let dateFormatter = DateFormatter()
    
    init(currentBtnEm: Binding<BtnEm>) {
        self._currentBtnEm = currentBtnEm
        
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
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
               /* NavigationLink(destination: QrGeneratorView(), tag: 1, selection: self.$action) {
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
                    if self.idconmonto == ""{
                        self.userDataVM.DatosUserPago(id_usuario: self.resultado)
                    }else{
                        self.userDataVM.DatosUserPago(id_usuario: self.idconmonto)
                    }
                   
                }
            }
            NavigationLink(destination: PayView(user: self.userDataVM.userResponsePago, montoQR: self.$montoQR), isActive: self.$userDataVM.nextPayview) {
                EmptyView()
            }
        }
      
    }
    
    var home:some View{
        ScrollView{
            VStack{
                Text("Recarga de línea pre pago")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack{
                    CardServiceHomeView(logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                    CardServiceHomeView(logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                    CardServiceHomeView(logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

            VStack{
                Text("Transporte")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack(spacing:10){
                    self.btnTeleferic
                    self.btnTransport
                        Spacer()
                            .frame(maxWidth:.infinity)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                HStack{
                    Button(action: {
                        //2021-01-18T21:53:57.977Z
                        
                        dateFormatter.dateFormat = "YYYY-MM-DDThh:mm:ss.sTZD"
                        print(dateFormatter.date(from: string) as Any)
                    }){
                        //Text("Aceptar")
                    }
                   
                    Text(self.resultado)
                   /* Text(self.resultado)
                  //  if self.qrPaymentVM.afiliado == true {
                        NavigationLink(destination: PayView(user: self.resultado, resultado: ""), tag: 2, selection: self.$action) {
                            EmptyView()
                        }*/
                  //  }
                    /*if  self.qrPaymentVM.noafiliado == nil {
                        Text("User no esta afiliado")
                            .foregroundColor(.red)
                        //self.alertState = true
                    }*/
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            HStack{
                if self.qrPaymentVM.noafiliado == nil{
                    Text("Usuario no afiliado")
                        .foregroundColor(.red)
                        .bold()
                    self.alertNoAfiliado()
                }
               
            }
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
        
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
        }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
            
    }
}
extension HomeView {
    func alertNoAfiliado() -> AnyView {
        if self.qrPaymentVM.noafiliado == nil {
            self.alertState = true
        }
        return AnyView(EmptyView())
    }
}

/*
 if self.resultado.contains("/") {
     print("existe monto")
      //var resultadomonto1 = self.resultado.split(separator: "/")
     self.resultadomonto = self.resultado.split(separator: "/")
     print(self.resultadomonto)
     print("iduser \(resultadomonto [0])")
     print("monto \(resultadomonto [1])")
     var convString: String = self.resultadomonto.reduce(",") { $0 + " " + $1 }
     //self.qrPaymentVM.userAfiliacion(id_afiliado: self.resultadomonto[0] as! String)
     self.showScannerTransporte = false
 }
 **/
