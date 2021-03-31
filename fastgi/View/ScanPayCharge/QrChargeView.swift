//
//  QrChargeView.swift
//  fastgi
//
//  Created by Hegaro on 03/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import CarBode
struct QrChargeView: View {
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var showBtn: Bool? = true
    
    var dataUserlog: UserModel
    
    //barcode generator
    //@State var id = Strin
    @State var dataString : String = ""
    @State var barcodeType = CBBarcodeView.BarcodeType.barcode128
    @State var rotate = CBBarcodeView.Orientation.up
    @State var barcodeImage: UIImage?
    //alert
    @State private var showingAlert = false
    //modal para el monto
    @State var modal = false
    @State var monto = ""
    //compartir img
    @State var items : [Any] = []
    @State var sheet = false
    @State var testImg: UIImage?
    //
   
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
                    .frame(width: 100.0, height: 100.0)
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
                        .font(.title)
                        .bold()
                }else{
                    Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                        .font(.title)
                        .bold()
                }
                if self.monto == ""{
                    //barcode
                    CBBarcodeView(data: .constant(self.dataUserlog._id) ,// self.dataUserlog._id,//$dataString,
                        barcodeType: $barcodeType,
                        orientation: $rotate)
                        { image in
                            self.barcodeImage = image
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .topLeading)//400
                    
                    //qr
                    Image(uiImage: generarQR(text: self.dataUserlog._id))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 290, height: 290)
                }else{
                    CBBarcodeView(data: .constant("\(self.dataUserlog._id),\(self.monto)" ) ,// self.dataUserlog._id,//$dataString,
                        barcodeType: $barcodeType,
                        orientation: $rotate)
                        { image in
                            self.barcodeImage = image
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .topLeading)//400
                    
                    //qr
                    Image(uiImage: generarQR(text: "\(self.dataUserlog._id),\(self.monto)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
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
                    
                    Button(action: {
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
                    /*Button(action: {
                        self.testImg = self.vista.snapshot()
                           self.showingSheet = true
                       }) {
                           Text("Share")
                       }
                       .sheet(isPresented: $showingSheet,
                              content: {
                                ActivityView(activityItems: [self.testImg as Any], applicationActivities: nil) })
                    */
                   /* Button("Decargar") {
                        let image = self.vista.snapshot()
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        showingAlert = true
                    }.buttonStyle(PrimaryButtonOutlineStyle())*/
                }
                /*.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Fastgi"), message: Text("Descarga completa"), dismissButton: .default(Text("Aceptar")))
                }*/
               
            }
        }
    
    }
}

/*struct QrChargeView_Previews: PreviewProvider {
    static var previews: some View {
        QrChargeView(, dataUserlog: <#UpdateUserModel#>)
    }
}*/
// share

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}


struct ShareSheet : UIViewControllerRepresentable {
    var items : [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

