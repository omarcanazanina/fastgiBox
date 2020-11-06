//
//  HomeView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @Binding var currentBtnEm: BtnEm
    
    init(currentBtnEm: Binding<BtnEm>) {
        
        self._currentBtnEm = currentBtnEm
        
        //Config for NavigationBar Transparent
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
    var home:some View{
        ScrollView{
           // HeaderUserView(text: self.loginVM.user.nombres, _id :self.loginVM.user._id)
            HStack{
                CardServiceHomeView(logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                CardServiceHomeView(logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                CardServiceHomeView(logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
                
                Spacer()
            }.padding(.horizontal)
        }.padding(.top)
        
    }
    
    var body: some View {
        VStack{
            HeaderUserView(text: self.loginVM.user.nombres, _id :self.loginVM.user._id)
                .padding(.leading)
                .padding(.top,45)
            self.home
                .onAppear{
                    self.loginVM.DatosUser()
                    print(self.loginVM.user)
                }
        }
        .edgesIgnoringSafeArea(.top)
        //.edgesIgnoringSafeArea(.all)
       /* .navigationBarTitle("Home", displayMode: .inline)
        .navigationBarItems(
            leading:
                HeaderUserView(text: self.loginVM.user.nombres, _id :self.loginVM.user._id)
        ) */
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentBtnEm: .constant(.Entel))
    }
}

