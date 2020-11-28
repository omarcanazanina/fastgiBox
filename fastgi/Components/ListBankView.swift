//
//  ListBankView.swift
//  fastgi
//
//  Created by Amilkar on 11/27/20.
//

import SwiftUI
struct ListBankView: View {
    @Binding var showingSheet:Bool
    @Binding var bank:String
    var list:some View{
        List{
            Button(action: {
                self.showingSheet = false
                self.bank = "Bank 1"
            })
            {
                HStack(){
                    Text("🏦 Bank 1")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Bank 2"
            })
            {
                HStack(){
                    Text("🏦 Bank 2")
                }
            }
        }
    }
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige un banco"), displayMode: .inline)
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
struct ListBankView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var bank: String = ""
    static var previews: some View {
        ListBankView(showingSheet: $showingSheet,bank: $bank)
    }
}
