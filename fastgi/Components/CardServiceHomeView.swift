//
//  CardServiceHomeView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct CardServiceHomeView: View {
    var logo : String
    @State var isSelect:Bool
    @ObservedObject var login = Login()
    @State private var  estado : Bool = false
    //
    @Binding var currentBtnEm: BtnEm
    //navegation
    @State private var action:Int? = 0
    let btn: BtnEm
    var body: some View {
        HStack{
            Button(action: {
                //self.login.ruta = "recargas"
                self.action = 1
                self.currentBtnEm = self.btn
            }) {
                Image(logo)
                    .resizable()
                    .frame(width:80, height: 80)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(  isSelect ? Color("primary") : Color("card"), lineWidth: 4)
                )
            }.buttonStyle(PlainButtonStyle())
            if self.logo == "Entel"{
                NavigationLink(destination: FormLoadCreditView(SelectEm: .Entel, montoRecarga1: .Btn10, montoRecarga: ""), tag: 1, selection: self.$action) {
                    EmptyView()
                }
               /* NavigationLink(destination: FormLoadCreditView(Empresa: self.logo, montoRecarga: "10" , text: "10 Bs.", montoRecarga1: .Btn10, SelectEm: .Entel), tag: 1, selection: self.$action) {
                    EmptyView()
                }*/
            }else if self.logo == "Viva"{
                NavigationLink(destination: FormLoadCreditView(SelectEm: .Entel, montoRecarga1: .Btn10, montoRecarga: ""), tag: 1, selection: self.$action) {
                    EmptyView()
                }
               /* NavigationLink(destination: FormLoadCreditView(Empresa: self.logo, montoRecarga: "10", text: "10 Bs.", montoRecarga1: .Btn10, SelectEm: .Viva), tag: 1, selection: self.$action) {
                    EmptyView()
                }*/
            }else{
                NavigationLink(destination: FormLoadCreditView(SelectEm: .Entel, montoRecarga1: .Btn10, montoRecarga: ""), tag: 1, selection: self.$action) {
                    EmptyView()
                }
                /*NavigationLink(destination: FormLoadCreditView(Empresa: self.logo, montoRecarga: "10", text: "10 Bs.", montoRecarga1: .Btn10, SelectEm: .Tigo), tag: 1, selection: self.$action) {
                    EmptyView()
                }*/
            }
        }
            
        .background(Color("card"))
        .cornerRadius(10)
        .frame(maxWidth:.infinity)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
       
        
    }

}

struct CardServiceHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CardServiceView(logo: "Entel", isSelect: true, currentBtnEm: .constant(.Entel), btn: .Entel)
       // CardServiceView(logo: "Entel", isSelect: true)
    }
}




