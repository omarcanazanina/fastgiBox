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
    @State private var showScanner = false
    @State private var resultado = ""
    
    @State private var action:Int? = 0
    //test
    @ObservedObject var qrPayment = QrPayment()
    @ObservedObject var qrPaymentVM = QrPaymentViewModel()
    @ObservedObject var userData = UserData()
    @ObservedObject var userDataVM = UserDataViewModel()
    @State var test = ""
    
    init(currentBtnEm: Binding<BtnEm>) {
        self._currentBtnEm = currentBtnEm
        
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var btnTeleferic:some View{
        Button(action: {
            self.showScanner = true
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
        .sheet(isPresented: self.$showScanner) {
            CodeScannerView(codeTypes: [.qr]){ result in
                switch result {
                case .success(let codigo):
                    self.resultado = codigo
                    self.showScanner = false
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
                self.showScanner = true
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
            .sheet(isPresented: self.$showScanner) {
                CodeScannerView(codeTypes: [.qr]){ result in
                    switch result {
                    case .success(let codigo):
                        self.resultado = codigo
                        //self.qrPaymentVM.userVerifi(id_cobrador: self.resultado)
                        //self.qrPayment.verificaUser(id_cobrador: codigo)
                        //self.showScanner = false
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            NavigationLink(destination: PayView(user: "\(self.userDataVM.userPago.nombres) \(self.userDataVM.userPago.apellidos)", resultado: self.resultado), tag: 1, selection: self.$action) {
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
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        
        }
        .padding()
    }
    
    var body: some View {
        HStack{
            self.home
        }
             .onAppear{
            print("SE EJECUTO EL ONAPPEAR \(self.resultado)")
            self.userDataVM.DatosUserPago(id_usuario: self.resultado)
           // self.qrPaymentVM.userVerifi(id_cobrador: self.resultado)
            
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
            
    }
}



/*VStack{
   // Text("usuario respuesta\(self.userDataVM.userPago.nombres)")
   // Text("llego el user\(self.test)")
    /*if self.qrPaymentVM.messageError != ""{
        Text("Usuario inexistente")
        //Text("llego el user\(self.qrPaymentVM.messageError)")
    }else {
        Text("todo correcto")
    }*/
    
    Button(action:{
     // self.recargas.sendRecarga(empresa: .Entel, recarga: "10", telefono: "79434343", text: "")
      // self.qrPayment.verificaUser(id_cobrador: "5fbe3893dee3371becd7bbf11")
        self.qrPaymentVM.userVerifi(id_cobrador: "5fbe3893dee3371becd7bbf11")
        //self.userDataVM.DatosUserPago(id_usuario: self.test)
  }){
   //   Text("verifica")
  }
}*/
// Text(self.resultado)

/*     NavigationLink(destination: PayView(monto: self.resultado), tag: 1, selection: self.$action) {
    EmptyView()
}*/
