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
    @ObservedObject var loginVM = LoginViewModel()
    @Binding var currentBtnEm: BtnEm
    //
    
    @State var text = ""
    
    //lector qr
    @State private var showScanner = false
    @State private var resultado = ""
    
    @State private var action:Int? = 0
    
    init(currentBtnEm: Binding<BtnEm>) {
        
        self._currentBtnEm = currentBtnEm
        
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
    var home:some View{
        ScrollView{
            HStack{
                CardServiceHomeView(logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                CardServiceHomeView(logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                CardServiceHomeView(logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
                Spacer()
            }.padding(.horizontal)
            Button(action: {
                self.showScanner = true
            }){
                Text("escanear QR")
            }.sheet(isPresented: self.$showScanner) {
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
            Text(self.resultado)
           
        }.padding(.top)
       
        
    }
    
    var body: some View {
        HStack{
            self.home
          
                .onAppear{
                    self.loginVM.DatosUser()
                    print(self.loginVM.user)
                }
        }
}
   
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
    }
}

