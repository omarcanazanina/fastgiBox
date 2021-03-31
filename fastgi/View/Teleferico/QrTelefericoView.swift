//
//  QrTeleferico.swift
//  fastgi wallet
//
//  Created by Hegaro on 29/03/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import UIKit

import SDWebImageSwiftUI
import CarBode

struct QrTelefericoView: View {
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var showBtn: Bool? = true
    var nombreUser : String = ""
    var dataUserlog: UserModel
    @State private var action:Int? = 0
    //modal
    @State var modal = false
    @State var monto = ""
    //barcode generator
    @State var dataString : String = ""
    @State var barcodeType = CBBarcodeView.BarcodeType.barcode128
    @State var rotate = CBBarcodeView.Orientation.up
    @State var barcodeImage: UIImage?
    
    // compartir img
    @State var items : [Any] = []
    @State var sheet = false
    
    
    //funcion generar QR
    func generarQR(text: String) -> UIImage{
        let data = Data(text.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let img = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage:img).resized(toWidth: 512) ?? UIImage()
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
    
    
    var imageProfile:some View {
        VStack{
            Image("Mi_teleferico")
                .resizable()
                .frame(width:80, height: 80)
                .padding(10)
        }
       
    }
    
    
    var vista: some View {
        VStack{
            /*self.imageProfile
            if self.dataUserlog.nombres == Optional(""){
                Text("+591 \(self.dataUserlog.telefono)")
                    .font(.title)
                    .bold()
            }else{
                Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                    .font(.title)
                    .bold()
                /* Text(nombreUser)
                 .font(.title)
                 .bold()*/
            }*/
            Text("Mi FastgiQr")
            // if self.user.score == 0 {
            if self.monto == "" {
                
                Image(uiImage: generarQR(text: self.dataUserlog._id))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                
            }else {
                //qr
                Image(uiImage: generarQR(text: "\(self.dataUserlog._id)\(self.monto)"))//self.user.score
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            
            if self.monto != ""{
                Text("\(self.monto) Bs.")
                    .font(.title)
            }
        }
    }
    

    
    var body: some View {
        ScrollView{
            self.vista
            VStack{
                HStack{
                    Text("NOMBRES")
                        .textStyle(TitleStyle())
                    Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                        //Text(self.loginVM.user.nombres)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "person.fill")
                            .font(.caption)
                            //.resizable()
                            //.frame(width: 100, height: 200)
                    }
                    
                }
                HStack{
                    Text("NUMERO CELULAR")
                        .textStyle(TitleStyle())
                    Text("+591 \(self.dataUserlog.telefono)")
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "phone.fill")
                            .font(.caption)
                            //.resizable()
                            //.frame(width: 100, height: 200)
                    }
                }
                HStack{
                    Text("CORREO ELECTRÓNICO")
                        .textStyle(TitleStyle())
                    Text("\(self.dataUserlog.correo ?? "") ")
                        //Text(self.loginVM.user.correo)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "envelope.fill")
                            .font(.caption)
                            //.resizable()
                            //.frame(width: 100, height: 200)
                    }
                }
              
                HStack{
                    Text("NIT")
                        .textStyle(TitleStyle())
                    Text("\(self.dataUserlog.nit ?? "")")
                        //Text(self.loginVM.user.apellidos)
                        .padding(.trailing)
                        .frame(maxWidth:.infinity, alignment: .trailing)
                    Button(action: {
                        self.action = 1
                    }){
                        Image(systemName: "person.crop.circle.fill")
                            .font(.caption)
                            //.resizable()
                            //.frame(width: 100, height: 200)
                    }
                }
                self.imageProfile
                HStack{
                    Button(action: {
                        self.action = 2
                    }) {
                            Text("Aceptar")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                }
             
                
            }.navigationBarTitle(Text("Pago mi teleférico"), displayMode: .inline)
            NavigationLink(destination: FormUserTelefericoView(), tag: 1, selection: self.$action) {
                EmptyView()
            }
            NavigationLink(destination: DetalleTelefericoView(), tag: 2, selection: self.$action) {
                EmptyView()
            }
               /* HStack {
                    Button(action: {
                        self.modal.toggle()
                    })
                    {
                        Text("Monto")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                    .sheet(isPresented: $modal) {
                        EnterAmountView(modal: self.$modal, monto: self.$monto)
                    }
                    // if self.showBtn! {
                    Button(action: {
                        //self.exportToPDF(nombreUser_: "\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")", showBtn_: false, monto_: self.monto)
                        items.removeAll()
                        items.append(self.vista.snapshot())
                        //items.append(UIImage(named: self.imageShare)!)
                        sheet.toggle()
                    }){
                        Text("Compartir")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                    .sheet(isPresented: $sheet, content: {
                        ShareSheet(items: items)
                    })
                }*/
            //}
        }
        .padding()
    }
}



