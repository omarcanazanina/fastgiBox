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
            Button(action: {
                self.action = 1
            }){
                HStack{
                    Image("Transport")
                        .resizable()
                        .frame(width:80, height: 80)
                        .padding(10)
                }
                .background(Color("card"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
            NavigationLink(destination: SlideFormJoinView(), tag: 1, selection: self.$action) {
                EmptyView()
            }
           /* Button(action: {
                self.action = 2
            }){
                HStack{
                    Image("Transport")
                        .resizable()
                        .frame(width:80, height: 80)
                        .padding(10)
                }
                .background(Color("card"))
                .cornerRadius(10)
                .frame(maxWidth:.infinity)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
            NavigationLink(destination: RegistrationFormView1(), tag: 2, selection: self.$action) {
                EmptyView()
            }*/
        }
     
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}
