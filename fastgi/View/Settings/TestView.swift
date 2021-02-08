//
//  TestView.swift
//  fastgi
//
//  Created by Hegaro on 29/01/2021.
//

import SwiftUI

struct TestView: View {
    @Binding var selectedMenuItem: MenuItem
    @ObservedObject var userDataVM = UserDataViewModel()
    var logo : String
    @State var isSelect:Bool
    var infoUser:some View{
        ScrollView(){
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 8){
                    Text("DATOS PERSONALES")
                        .textStyle(TitleStyle())
                    HStack{
                        Text("DOCUMENTO DE IDENTIDAD")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.ci)
                        //Text(self.loginVM.user.ci)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("CORREO ELECTRÓNICO")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.correo)
                        //Text(self.loginVM.user.correo)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("NOMBRES")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.nombres)
                        //Text(self.loginVM.user.nombres)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("APELLIDOS")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.apellidos)
                        //Text(self.loginVM.user.apellidos)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("DIRECCIÓN")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.direccion)
                        //Text(self.loginVM.user.direccion)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    Divider()
                    
                    Text("DATOS DE FACTURACIÓN")
                        .textStyle(TitleStyle())
                    HStack{
                        Text("NOMBRE")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.nombrenit)
                            //Text(self.loginVM.user.nombrenit)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        
                        Text("NIT")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.nit)
                            //Text(self.loginVM.user.nit)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                }
                VStack(alignment: .leading, spacing: 8){
                    Divider()
                    NavigationLink(destination:  FormLoadCreditView(contContacts:0, empresa: self.logo, SelectEm: .Entel, MontoRecarga1: .Btn30, MontoRecarga: "")) {
                        HStack{
                            Image(systemName: "creditcard")
                            Text("MÉTODOS DE PAGO")
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                        }
                    }
                 
                  
                }
            }
            self.home2
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top,.leading])
    }
    
    var home2:some View{
        Text("rec \(self.userDataVM.user.nombres)")
        .padding()
        
    }
    
    
    var body: some View {
        //Text(self.userDataVM.user.nombres)
       //self.infoUser
    
        return self.infoUser
                    //self.home2//Text("test \(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)")
                .onAppear(perform: {
                    print("llego en el test \(selectedMenuItem)")
                    if MenuItem.TEST == selectedMenuItem {
                        print("-> TestView")
                        self.userDataVM.DatosUser()
                    }
                })
        }
}

/*struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(selectedMenuItem: $selectedMenuItem)
    }
}*/
