//
//  NewHomeView.swift
//  fastgi
//
//  Created by Hegaro on 02/02/2021.
//

import SwiftUI

struct NewHomeView: View {
    @Binding var selectedMenuItem: MenuItem
    @ObservedObject var userDataVM = UserDataViewModel()
    var dataq: some View {
        Text("Hello, newhome! ")
    }
    
    var body: some View{
        //self.dataq
            
        return self.dataq
                .onAppear(perform: {
                   //print("llego en el newhome \(selectedMenuItem)")
                    if MenuItem.HOME == selectedMenuItem {
                        print("-> newHomeView")
                        self.userDataVM.DatosUser()
                        print("en la vista")
                    }
                })
    }
}

struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView(selectedMenuItem: .constant(.HOME))
    }
}
