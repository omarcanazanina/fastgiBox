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
            Image("Factura")
                .shadow(radius: 4.0)
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 10){
                self.logo
                    .padding(.top,20)
                Text("Comprobante Electrónico")
                
                Text("Pago de teleférico")

                VStack{
                    self.vista
                  
                    Button("Decargar") {
                        let image = self.vista.snapshot()
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        showingAlert = true
                    }
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .padding()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Fastgi"), message: Text("Descarga completa"), dismissButton: .default(Text("Aceptar")))
                }
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
