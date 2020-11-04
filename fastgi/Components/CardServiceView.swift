//
//  CardServiceView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

enum BtnEm {
    case Entel
    case Viva
    case Tigo
}

struct CardServiceView: View {
    var logo : String
    @State var isSelect:Bool
    @ObservedObject var login = Login()
    @State private var  estado : Bool = false
    //
   @Binding var currentBtnEm: BtnEm
    let btn: BtnEm
    var body: some View {
        HStack{
            Button(action: {
                self.currentBtnEm = self.btn
                //print(self.currentBtnEm)
            }) {
                Image(logo)
                    .resizable()
                    .frame(width:60, height: 60)
                    .padding(6)
                    .foregroundColor(self.currentBtnEm == btn ? Color.white : Color("normal-text"))
                                   .frame(maxWidth:.infinity)
                                   .padding(8)
                                   .background(Color("card"))
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(  self.currentBtnEm == btn  ? Color("primary") : Color("card"), lineWidth: 4)
                )
            }
           /* NavigationLink(destination: TestFormLoadCreditView(Empresa: self.logo, montoRecarga: .Btn10), tag: "recargas", selection: self.$login.ruta) {
                EmptyView()
            }*/
           
        //}
                //Remove style button
                .buttonStyle(PlainButtonStyle())
            
            
        }
            
            
        .background(Color("card"))
        .cornerRadius(10)
        //.frame(maxWidth:.infinity)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)

    }
    
}

struct CardServiceView_Previews: PreviewProvider {
    static var previews: some View {
        //TestCardServiceView(logo: "Entel", isSelect: true)
        CardServiceView(logo: "Tigo", isSelect: true, currentBtnEm: .constant(.Tigo), btn: .Tigo)
    }
}



