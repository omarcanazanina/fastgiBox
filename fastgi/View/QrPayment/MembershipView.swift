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
        ScrollView{
            VStack{
                Text("Seleccione servicio")
                    .font(.caption)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack{
                    Button(action: {
                        self.action = 1
                    }){
                        HStack(spacing:10){
                            Image("Transport")
                                .resizable()
                                .frame(width:80, height: 80)
                                .padding(10)
                                //Spacer()
                                //.frame(maxWidth:.infinity)
                        }
                        .background(Color("card"))
                        .cornerRadius(10)
                        //.frame(maxWidth:.infinity)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                        
                    }
                    NavigationLink(destination: SlideFormJoinView(), tag: 1, selection: self.$action) {
                        EmptyView()
                    }
                  
                }
            }
        }.padding()
     
    }
}

struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
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
