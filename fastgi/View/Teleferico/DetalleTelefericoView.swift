//
//  DetalleTelefericoView.swift
//  fastgi wallet
//
//  Created by Hegaro on 30/03/2021.
//

import SwiftUI

struct DetalleTelefericoView: View {
    // compartir img
    @State var items : [Any] = []
    @State private var showingAlert = false
    
    var logo: some View{
        Image("logo_fastgi")
            .resizable()
            .frame(width: 80, height: 80)
    }
    var vista: some View {
        VStack{
            Image("Comprobanteteleferico")
                .resizable()
                .frame(width:300, height: 300)
                .padding(10)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            self.logo
                .padding(.top,30)
            Text("Comprobante Electrónico")
                .foregroundColor(.black)
                .font(.title3)
            
            Text("Pago de teleférico")
                .foregroundColor(.black)
                .padding(.bottom,30)
            VStack{
                self.vista
              
                Button("Decargar") {
                    let image = self.vista.snapshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    showingAlert = true
                }.buttonStyle(PrimaryButtonOutlineStyle())
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Fastgi"), message: Text("Descarga completa"), dismissButton: .default(Text("Aceptar")))
            }
        }
    }
  
}

struct DetalleTelefericoView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleTelefericoView()
    }
}

/*
Button(action: {
   items.removeAll()
   items.append(UIImage(named: "Comprobanteteleferico")!)
   //items.append(UIImage(named: self.imageShare)!)
}){
   Text("Descargar")
}.buttonStyle(PrimaryButtonOutlineStyle())
*/
