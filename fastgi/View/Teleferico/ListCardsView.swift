//
//  ListCardsView.swift
//  fastgi wallet
//
//  Created by Hegaro on 30/03/2021.
//


import SwiftUI
struct ListCardsView: View {
    @Binding var showingSheet:Bool
    @Binding var card:String
    var list:some View{
        List{
            Button(action: {
                self.showingSheet = false
                self.card = "Caja"
            })
            {
                HStack(){
                    Text("🏦 Caja")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "********3242"
            })
            {
                HStack(){
                    Text("🏦 ********3242")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "********4566"
            })
            {
                HStack(){
                    Text("🏦 ********4566")
                }
            }
    
            Button(action: {
                self.showingSheet = false
                self.card = "********3344"
            })
            {
                HStack(){
                    Text("🏦 ********3344")
                }
            }
            
        }
    }
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige una tarjeta"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showingSheet = false
                }) {
                    Text("Cerrar")
                        .bold()
                        .foregroundColor(Color("primary"))
                })
        }
    }
}
struct ListCardsView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var bank: String = ""
    static var previews: some View {
        ListCardsView(showingSheet: $showingSheet,card: $bank)
    }
}
