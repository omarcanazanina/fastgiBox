//
//  QrPayView.swift
//  fastgi wallet
//
//  Created by Hegaro on 16/03/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct QrPayView: View {
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var showBtn: Bool? = true
    
    var dataUserlog: UserModel
    
    //barcode generator
    //@State var id = Strin
    @State var dataString : String = ""
    //alert
    @State private var showingAlert = false
    //modal para el monto
    @State var modal = false
    @State var monto = ""
    //compartir img
    @State var items : [Any] = []
    @State var sheet = false
    
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
        HStack(alignment: .center){
                WebImage(url: URL(string: "https://i.postimg.cc/8kJ4bSVQ/image.jpg" ))
                    .onSuccess { image, data, cacheType in
                    }
                    .placeholder(Image( "user-default"))
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .overlay(
                        Circle()
                            .stroke(Color("card"), lineWidth: 2))
            
        }
        
    }
    
    var vista:some View {
        ScrollView{
            VStack{
                self.imageProfile
                if self.dataUserlog.nombres == Optional("") || self.dataUserlog.nombres == nil{
                    Text("+591 \(self.dataUserlog.telefono)")
                        .font(.subheadline)
                        //.bold()
                }else{
                    Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                        .font(.subheadline)
                        //.bold()
                }
                if self.monto == ""{
                    //qr
                    Image(uiImage: generarQR(text: "pagar,\(self.dataUserlog._id)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }else{
                    //qr
                    Image(uiImage: generarQR(text: "pagar,\(self.dataUserlog._id),\(self.monto)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                if self.monto != ""{
                    Text("\(self.monto) Bs.")
                        .font(.title)
                }
              
            }
            .padding(30)
        }
        
    }
    
    var body: some View {
        ScrollView{
            VStack{
                self.vista
                HStack{
                    Button(action: {
                        self.modal.toggle()
                    }){
                        Text("Monto")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                    .sheet(isPresented: $modal) {
                        EnterAmountView(modal: self.$modal, monto: self.$monto)
                    }
                    
                   /* Button(action: {
                        items.removeAll()
                        items.append(self.vista.snapshot())
                        //items.append(UIImage(named: self.imageShare)!)
                        sheet.toggle()
                    }){
                        Text("Compartir")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                    .sheet(isPresented: $sheet, content: {
                        ShareSheet(items: items)
                    })*/
                    Button("Decargar") {
                        let image = self.vista.snapshot()
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        showingAlert = true
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Fastgi"), message: Text("Descarga completa"), dismissButton: .default(Text("Aceptar")))
                }
            }.navigationBarTitle(Text("Cobrar"), displayMode: .inline)
        }
    }
}

//metodo para descargar imagen
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


/*struct QrPayView_Previews: PreviewProvider {
    static var previews: some View {
        QrPayView()
    }
}*/

