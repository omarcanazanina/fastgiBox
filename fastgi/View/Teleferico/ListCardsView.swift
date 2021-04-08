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
                self.card = "Saldo"
            })
            {
                HStack(){
                    Text("🏦 Saldo")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "* * * * 4 4 5 4"
            })
            {
                HStack(){
                    Text("💳 * * * * 4 4 5 4")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "* * * * 2 4 6 2"
            })
            {
                HStack(){
                    Text("💳 * * * * 2 4 6 2")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.card = "* * * * 2 6 2 7"
            })
            {
                HStack(){
                    Text("💳 * * * * 2 6 2 7")
                }
            }
    
            NavigationLink(destination: FormCreditCardView()) {
             Text("+ Agregar tarjeta")
                 .foregroundColor(Color("primary"))
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
