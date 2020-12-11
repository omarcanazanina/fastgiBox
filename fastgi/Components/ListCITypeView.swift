//
//  ListCITypeView.swift
//  fastgi
//
//  Created by Amilkar on 12/8/20.
//

import SwiftUI

struct ListCITypeView: View {
    @Binding var showingSheet:Bool
    @Binding var CIType:String
    var list:some View{
        List{
            Button(action: {
                self.showingSheet = false
                self.CIType = "CH"
            })
            {
                HStack(){
                    Text("Chuquisaca")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "LP"
            })
            {
                HStack(){
                    Text("La Paz")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "CB"
            })
            {
                HStack(){
                    Text("Cochabamba")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "OR"
            })
            {
                HStack(){
                    Text("Oruro")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "PT"
            })
            {
                HStack(){
                    Text("Potosí")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "TJ"
            })
            {
                HStack(){
                    Text("Tarija")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "SC"
            })
            {
                HStack(){
                    Text("Santa Cruz")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "BE"
            })
            {
                HStack(){
                    Text("Beni")
                }
            }
            Button(action: {
                self.showingSheet = false
                self.CIType = "PD"
            })
            {
                HStack(){
                    Text("Pando")
                }
            }
        }
    }
    var body: some View {
        NavigationView {
            self.list
                .navigationBarTitle(Text("Elige un departamento"), displayMode: .inline)
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
struct ListCITypeView_Previews: PreviewProvider {
    @State static var showingSheet = true
    @State static var CIType: String = ""
    static var previews: some View {
        ListCITypeView(showingSheet: $showingSheet,CIType: $CIType)
    }
}
