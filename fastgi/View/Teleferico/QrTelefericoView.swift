//
//  QrTeleferico.swift
//  fastgi wallet
//
//  Created by Hegaro on 29/03/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import UIKit

import SDWebImageSwiftUI
import CarBode

struct QrTelefericoView: View {
    var dataUserlog: UserModel
    @State private var action:Int? = 0
    //
    @State var showingSheetBank = false
    @State var card: String = "* * * *  3 4 5 6"
    @State private var showingSheet = false
    
    var imageProfile:some View {
        VStack{
            Image("Teleferico")
                .resizable()
                .frame(width:80, height: 80)
                .padding(10)
        }
    }
    
    var pickerCard: some View{
        VStack{
            Text("")
            Button(action: {
                self.showingSheetBank.toggle()
            }) {
                HStack{
                    Text(self.card)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.caption)
                        .foregroundColor(Color("primary"))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showingSheetBank) {
                ListCardsView(
                    showingSheet: self.$showingSheetBank,
                    card: self.$card)
            }
        }
    }
    
    var body: some View {
        ScrollView{
           // self.vista
            VStack{
                Text("")
                Text("")
                Image("Qr")
                Text("")
                Text("")
                Text("")
            }
            VStack{
                HStack{
                    Text("NOMBRES")
                        .textStyle(TitleStyle())
                    Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                        //Text(self.loginVM.user.nombres)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "person.fill")
                            .font(.caption)
                    }
                }
                Text("")
                HStack{
                    Text("NUMERO CELULAR")
                        .textStyle(TitleStyle())
                    Text("+591 \(self.dataUserlog.telefono)")
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "phone.fill")
                            .font(.caption)
                    }
                }
                Text("")
                HStack{
                    Text("CORREO ELECTRÓNICO")
                        .textStyle(TitleStyle())
                    Text("\(self.dataUserlog.correo ?? "") ")
                        //Text(self.loginVM.user.correo)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "envelope.fill")
                            .font(.caption)
                    }
                }
                Text("")
                HStack{
                    Text("NIT/CI")
                        .textStyle(TitleStyle())
                    Text("\(self.dataUserlog.nit ?? "")")
                        //Text(self.loginVM.user.apellidos)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "person.crop.circle.fill")
                            .font(.caption)
                    }
                   
                }
                HStack{
                    Text("TARJETA")
                        .textStyle(TitleStyle())
                    self.pickerCard
                }
                
                self.imageProfile
                HStack{
                    Button(action: {
                        self.action = 2
                    }) {
                            Text("Aceptar")
                                .foregroundColor(Color.white)
                                .frame(maxWidth:.infinity)
                                .padding(8)
                                .background(Color("primary"))
                                .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                                .padding()
                    }
                }
             
                
            }.navigationBarTitle(Text("Pago mi teleférico"), displayMode: .inline)
            NavigationLink(destination: FormUserTelefericoView(), tag: 1, selection: self.$action) {
                EmptyView()
            }
            NavigationLink(destination: DetalleTelefericoView(), tag: 2, selection: self.$action) {
                EmptyView()
            }
        }
        .padding()
    }
}



