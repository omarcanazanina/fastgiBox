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

struct QrGeneratorView: View {
    var monto: String
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var showBtn: Bool? = true
    var nombreUser : String = ""
    @State private var action:Int? = 0
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
    
    //funcion generar barcode
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
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
       // TextField("Texto a QR", text: self.$texto)
        VStack{
            self.imageProfile
           // let nombreUser = "\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)"
            Text("monto \(self.monto)")
            Text("\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)")
                .font(.title)
                .bold()
            Text(nombreUser)
                .font(.title)
                .bold()
            if self.monto == "" {
                Image(uiImage: generarQR(text: self.userDataVM.user._id))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }else {
                Image(uiImage: generarQR(text: "\(self.userDataVM.user._id)\(self.monto)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
            
            HStack {
                Button(action: {
                    self.action = 1
                })
                {
                    Text("Monto")
                }.buttonStyle(PrimaryButtonOutlineStyle())
                
                if self.showBtn! {
                    Button(action: {
                        self.exportToPDF(nombreUser_: "\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)", showBtn_: false)
                    }){
                        Text("Compartir")
                    }.buttonStyle(PrimaryButtonOutlineStyle())
                }
            }
            NavigationLink(destination: EnterAmountView(), tag: 1, selection: self.$action) {
                    EmptyView()
            }
        }

    }
}

struct QrGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            QrGeneratorView(monto: "")
                .previewDevice("iPhone 11")
                .preferredColorScheme(.dark)
        }
        
    }
}


extension QrGeneratorView {
    func exportToPDF(nombreUser_: String, showBtn_: Bool) {
        print(nombreUser_)
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("Fastgi.pdf")
        
        //Normal with
        let width: CGFloat = 8.5 * 72.0
        //Estimate the height of your view
        let height: CGFloat = 1000
        let charts = QrGeneratorView(monto: "", showBtn: showBtn_, nombreUser: nombreUser_)
        
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
