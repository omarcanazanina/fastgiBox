//
//  QrGeneratorView.swift
//  fastgi
//
//  Created by Hegaro on 25/11/2020.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import UIKit

import SDWebImageSwiftUI
import CarBode

struct QrGeneratorView: View {
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
    
    var body: some View {
        /*RefreshableNavigationView(title: "", action:{
            print("se actualizo")
           // self.numbers = self.generateRandomNumbers()
             }){
                 //Text("datos")
             }*/
        ScrollView{
            VStack{
                self.imageProfile
                if self.dataUserlog.nombres == Optional(""){
                    Text("+591 \(self.dataUserlog.telefono)")
                        .font(.title)
                        .bold()
                }else{
                    Text("\(self.dataUserlog.nombres ?? "") \(self.dataUserlog.apellidos ?? "")")
                        .font(.title)
                        .bold()
                    Text(nombreUser)
                        .font(.title)
                        .bold()
                }
                    
               // if self.user.score == 0 {
                    if self.monto == "" {
                        //barcode
                        CBBarcodeView(data: .constant(self.dataUserlog._id) ,// self.dataUserlog._id,//$dataString,
                                      barcodeType: $barcodeType,
                                      orientation: $rotate)
                        { image in
                            self.barcodeImage = image
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .topLeading)
                        
                    Image(uiImage: generarQR(text: self.dataUserlog._id))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }else {
                    //barcode"
                    CBBarcodeView(data: .constant("\(self.dataUserlog._id) \(self.monto)") ,// self.dataUserlog._id,//$dataString,
                        barcodeType: $barcodeType,
                        orientation: $rotate)
                        { image in
                            self.barcodeImage = image
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .topLeading)
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
         
                HStack {
                    Button(action: {
                        self.modal.toggle()
                    })
                    {
                        Text("Monto")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                    .sheet(isPresented: $modal) {
                        EnterAmountView(modal: self.$modal, monto: self.$monto)
                    }
                    
                    if self.showBtn! {
                        Button(action: {
                            self.exportToPDF(nombreUser_: "\(self.dataUserlog.nombres) \(self.dataUserlog.apellidos)", showBtn_: false)
                        }){
                            Text("Compartir")
                        }.buttonStyle(PrimaryButtonOutlineStyle())
                    }
                    Button(action: {
                        self.shareLink()
                    })
                    {
                        Text("Link")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                }
            }
        }
        
    }
}

/*struct QrGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            QrGeneratorView(dataUserlog: self.dataUserlog, monto: "")
                .previewDevice("iPhone 11")
                .preferredColorScheme(.dark)
        }
        
    }
}*/


extension QrGeneratorView {
    func exportToPDF(nombreUser_: String, showBtn_: Bool) {
        print(nombreUser_)
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("Fastgi.pdf")
        
        //Normal with
        let width: CGFloat = 8.5 * 72.0
        //Estimate the height of your view
        let height: CGFloat = 1000
        let charts = QrGeneratorView(showBtn: showBtn_, nombreUser: nombreUser_, dataUserlog: self.dataUserlog, monto: "")
        
        let pdfVC = UIHostingController(rootView: charts)
        pdfVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        //Render the view behind all other views
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        rootVC?.addChild(pdfVC)
        rootVC?.view.insertSubview(pdfVC.view, at: 0)
        
        //Render the PDF
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: height))
        
        do {
            try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                context.beginPage()
                
                pdfVC.view.layer.render(in: context.cgContext)
            })
            let items = [outputFileURL]
            let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
            

            
        }catch {
            //self.showError = true
            print("Could not create PDF file: \(error)")
        }
        
        pdfVC.removeFromParent()
        pdfVC.view.removeFromSuperview()
    }
    
}

extension QrGeneratorView {
    func shareLink() {
            guard let data = URL(string: "http://fastgi.com/") else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }
}
// mejorar la calidad de qr
extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: round(width), height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext();
        context?.interpolationQuality = .none
       
        draw(in: CGRect(origin: .zero, size: canvasSize))
        let r = UIGraphicsGetImageFromCurrentImageContext()
        return r
    }
}


