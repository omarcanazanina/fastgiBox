//
//  MenuView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var login = Login()
    private let storage = UserDefaults.standard
    @EnvironmentObject private var authState : AuthState
    var navigationRoot = NavigationRoot()
    //navigation


    func getCurrentYear() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack{
            List {
                Button(action: {
                    self.login.ruta = "updateform"
                }) {
                    HStack{
                        Image(systemName: "pencil")
                        Text("Editar datos")
                        Spacer()
                    }
                    NavigationLink(destination: FormUserDataView(), tag: "updateform", selection: self.$login.ruta) {
                        EmptyView()
                    }
                }
                /*Button(action: {
                    //self.action = 1
                }) {
                    HStack{
                        Image(systemName: "book")
                        Text("Términos de uso")
                    }
                }*/
                NavigationLink(destination: TermsAndConditionsView()) {
                    HStack{
                        Image(systemName: "book")
                        Text("Términos de uso")
                    }
                }
                /*NavigationLink(destination: AboutFastgiView()) {
                    HStack{
                        Image(systemName: "info.circle")
                        Text("Acerca de nosotros")
                    }
                }*/
                Button(action: {
                    self.authState.isAuth = false
                    self.navigationRoot.changeRootClose()
                }) {
                    HStack{
                        Image(systemName: "arrow.right.to.line.alt")
                        Text("Cerrar sesión")
                    }
                }
                
                
                Text("© \(self.getCurrentYear()) Fastgi")
                    .opacity(0.5)
            }
            
        }
        .navigationBarTitle("Opciones", displayMode: .inline)
        .accentColor( .red)
    }
    
    var bodyExample: some View {
        NavigationView {
            List(1..<13) { item in
                NavigationLink(destination: Text("\(item) x 8 = \(item*8)")) {
                    Text("Opcion \(String(item))")
                }
            }.navigationBarTitle("Opciones", displayMode: .inline)
        }.accentColor( .black) // <- note that it's added here and not on the List like navigationBarTitle()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
