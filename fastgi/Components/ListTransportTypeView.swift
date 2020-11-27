//
//  ListTransportTypeView.swift
//  fastgi
//
//  Created by Amilkar on 11/27/20.
//

import SwiftUI

struct ListTransportTypeView: View {
    @Binding var showingSheet:Bool
    @Binding var transportType:String
    var list:some View{
        List{
            Button(action: {
                self.showingSheet = false
                self.transportType = "Taxis"
            })
            {
                HStack(){
                    Text("Taxis")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.transportType = "Microbuses"
            })
            {
                HStack(){
                    Text("Microbuses")
                }
            }
        }
    }
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige un tipo de servicio"), displayMode: .inline)
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
struct ListTransportTypeView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var transportType: String = ""
    static var previews: some View {
        ListTransportTypeView(showingSheet: $showingSheet,transportType: $transportType)
    }
}
