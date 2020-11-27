//
//  ListAccountTypeView.swift
//  fastgi
//
//  Created by Amilkar on 11/27/20.
//

import SwiftUI

struct ListAccountTypeView: View {
    @Binding var showingSheet:Bool
    @Binding var accountType:String
    var list:some View{
        List{
            Button(action: {
                self.showingSheet = false
                self.accountType = "option1"
            })
            {
                HStack(){
                    Text("Cuenta corriente")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.accountType = "option2"
            })
            {
                HStack(){
                    Text("Cuenta de ahorros")
                }
            }
        }
    }
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige un tipo de cuenta"), displayMode: .inline)
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
struct ListAccountTypeView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var accountType: String = ""
    static var previews: some View {
        ListAccountTypeView(showingSheet: $showingSheet,accountType: $accountType)
    }
}
