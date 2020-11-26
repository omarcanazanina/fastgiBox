//
//  MembershipView.swift
//  fastgi
//
//  Created by Hegaro on 24/11/2020.
//

import SwiftUI

struct MembershipView: View {
    @State private var action:Int? = 0
    var body: some View {
       // Text("asd")
        HStack{
            Button(action:{
                self.action = 1
            }){
                Text("Pago")
            }
            NavigationLink(destination: RegistrationFormView(), tag: 1, selection: self.$action) {
                EmptyView()
            }
        }
     
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}
