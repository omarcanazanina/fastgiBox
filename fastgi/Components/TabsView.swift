//
//  TabsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab:Int? = 0
    @Binding var currentBtnEm: BtnEm
    var body: some View {
        NavigationView{
            TabView {
                HomeView(currentBtnEm: $currentBtnEm)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Inicio")
                    }
                HistoryView()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Historial")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Ajustes")
                    }
            }.accentColor(Color("primary"))
            //.navigationBarTitle("asd",displayMode: .inline)
        }
    }
}


struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView(currentBtnEm: .constant(.Entel))
        
    }
}
