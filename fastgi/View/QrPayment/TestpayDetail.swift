//
//  TestpayDetail.swift
//  fastgi
//
//  Created by Hegaro on 04/12/2020.
//

import SwiftUI

struct TestpayDetail: View {
    var monto : String
    var nombreCobrador: String
    var id_usuario: String
    var fecha: String
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    var navigationRoot = NavigationRoot()
    //fechaformat
    let date = Date()
    @State var fechaFormat : String
    @State var horaFormat : String
    var showBtn: Bool? = true
    
    let dateFormatter = DateFormatter()
    var dateStringFormatter = DateFormatter()
    
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
                    
                    Text("1254")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("FECHA")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text(self.fechaFormat)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("HORA")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text(self.horaFormat)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("SERVICIO")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("Pago transporte")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("ORIGINANTE")
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
                    
                    Text("\(self.nombreCobrador)")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                HStack{
                    Text("MONTO")
                        .foregroundColor(Color("primary"))
                        .bold()
                        .textStyle(TitleStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("\(self.monto).00 Bs.")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
          
            }
            Spacer()
            Button(action: {
                self.navigationRoot.setRootView()
            })
            {
                Text("OK")
            }
            if self.showBtn! {
                
                Button(action: {
                    self.exportToPDF(fecha_: self.fechaFormat, fechaFormat_: self.fechaFormat, horaFormat_: self.horaFormat, showBtn_: false, servicio_: "Pago transporte", nombreO_: "\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)", nombreA_: self.nombreCobrador, monto_: self.monto, id_usuario_:  "\(self.userDataVM.user.nombres) \(self.userDataVM.user.apellidos)")
                }){
                    Text("Compartir")
                }.buttonStyle(PrimaryButtonOutlineStyle())
                
            }
        }
        .onAppear{
          //  self.userDataVM.DatosUserPago(id_usuario: self.id_cobrador)
            print("fecharecibidaaqui\(self.fecha)")
            dateStringFormatter.dateFormat = "dd/MM/YYYY"// HH:mm:ss"
            let dateFromString = dateStringFormatter.date(from: self.fecha)
            self.fechaFormat = dateStringFormatter.string(from: dateFromString ?? date)
            print("la fechaFormat es \(dateFromString ?? date)")
            //horaformat
            dateStringFormatter.dateFormat = "HH:mm:ss"
            let horaFromString = dateStringFormatter.date(from: self.fecha)
            self.horaFormat = dateStringFormatter.string(from: horaFromString ?? date)
        }
       .background(Color.white)
    }
    
}

struct TestpayDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TestpayDetail(monto: "", nombreCobrador: "", id_usuario: "", fecha: "", fechaFormat: "", horaFormat: "")
                .previewDevice("iPhone 11")
                .preferredColorScheme(.dark)
        }
    }
}


extension TestpayDetail{
    func exportToPDF(fecha_: String,fechaFormat_: String,horaFormat_:String, showBtn_: Bool,servicio_: String, nombreO_: String,nombreA_: String,monto_: String,id_usuario_:String) {
        
        print(fecha_)
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("Fastgi.pdf")
        
        //Normal with
        let width: CGFloat = 8.5 * 72.0
        //Estimate the height of your view
        let height: CGFloat = 1000
        let charts = TestpayDetail(monto: monto_, nombreCobrador: nombreA_, id_usuario: id_usuario_, fecha: fecha_, fechaFormat: fechaFormat_, horaFormat: horaFormat_)
        
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
