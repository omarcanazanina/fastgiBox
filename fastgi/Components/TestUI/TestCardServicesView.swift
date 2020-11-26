//
//  TestCardServicesView.swift
//  fastgi
//
//  Created by Amilkar on 11/26/20.
//

import SwiftUI

struct TestCardServicesView: View {

    var isSelect:Bool? = true
    var body: some View {
        VStack{
            HStack{
                Image("Mi_teleferico")
                    .resizable()
                    .frame(width:80, height: 80)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(  self.isSelect! ? Color("primary") : Color("card"), lineWidth: 4)
                )
                Image("Transport")
                    .resizable()
                    .frame(width:80, height: 80)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(  self.isSelect! ? Color("primary") : Color("card"), lineWidth: 4)
                )
            }

            VStack(){
                
                Image(systemName: "person.circle")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("primary"))
                
                Image("handshakes")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("primary"))
            }
             
        }

        
    }
}

struct TestCardServicesView_Previews: PreviewProvider {
    static var previews: some View {
        TestCardServicesView()
    }
}
