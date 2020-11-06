//
//  FormCreditCardView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct FormCreditCardView: View {
    
    @State var testForm: String = ""
    var body: some View {
        VStack{
            ScrollView(){
                VStack(alignment: .leading, spacing: 8){
                    Text("TITULAR")
                        .textStyle(TitleStyle())
                    TextField("Nombre titutlar", text:  self.$testForm)
                        .textFieldStyle(Input())
                        Text("NÚMERO")
                            .textStyle(TitleStyle())
                    TextField("Número", text:  self.$testForm)
                        .textFieldStyle(Input())
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("MES / AÑO")
                                .textStyle(TitleStyle())
                            TextField("Mes / Año", text:  self.$testForm)
                                .textFieldStyle(Input())
                        }
                        VStack(alignment: .leading){
                            Text("CVV")
                                .textStyle(TitleStyle())
                            TextField("CVV", text:  self.$testForm)
                                .textFieldStyle(Input())
                        }
                    }
                    Button(action: {
                    }){
                        Text("Aceptar")
                            .foregroundColor(Color.white)
                            .frame(maxWidth:.infinity)
                            .padding(8)
                            .background(Color("primary"))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    }
                }
            }
        }.padding()
        
    }
}

struct FormCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        FormCreditCardView()
    }
}
