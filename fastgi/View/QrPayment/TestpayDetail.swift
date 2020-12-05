//
//  TestpayDetail.swift
//  fastgi
//
//  Created by Hegaro on 04/12/2020.
//

import SwiftUI

struct TestpayDetail: View {
    var monto : String
    var id_cobrador: String
    var id_usuario: String
    
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    
    var logo: some View{
        Image("logo_fastgi")
            .resizable()
            .frame(width: 80, height: 80)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            self.logo
                .padding(.top,30)
            Text("Comprobante Electrónico")
                .foregroundColor(.black)
                .font(.title3)
            
            Text("Pago por QR")
                .foregroundColor(.black)
                .padding(.bottom,30)
            
            VStack(alignment: .center, spacing: 10){
                HStack{
                    Text("Nro. TRANSACCIÓN")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("123")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("MONTO")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("Recarga \(self.monto)")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("ORIGEN")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("ABONADO")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("\(self.id_cobrador)")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            
        }.onAppear{
            self.userDataVM.DatosUser()
        }
        .background(Color.white)
    }
    
}

struct TestpayDetail_Previews: PreviewProvider {
    static var previews: some View {
        TestpayDetail(monto: "", id_cobrador: "", id_usuario: "")
    }
}
