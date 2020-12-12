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
                self.bank = "Bisa S.A."
            })
            {
                HStack(){
                    Text("🏦 Bisa S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Económico S.A."
            })
            {
                HStack(){
                    Text("🏦 Económico S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Fassil S.A."
            })
            {
                HStack(){
                    Text("🏦 Fassil S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Fortaleza S.A."
            })
            {
                HStack(){
                    Text("🏦 Fortaleza S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Ganadero S.A."
            })
            {
                HStack(){
                    Text("🏦 Ganadero S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Prodem S.A."
            })
            {
                HStack(){
                    Text("🏦 Prodem S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Unión S.A."
            })
            {
                HStack(){
                    Text("🏦 Unión S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Mercantil Santa Cruz S.A."
            })
            {
                HStack(){
                    Text("🏦 Mercantil Santa Cruz S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Nacional de Bolivia S.A."
            })
            {
                HStack(){
                    Text("🏦 Nacional de Bolivia S.A.")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.bank = "Fomento a Iniciativas Económicas S.A."
            })
            {
                HStack(){
                    Text("🏦 Fomento a Iniciativas Económicas S.A.")
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
