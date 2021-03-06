//
//  MembershipView.swift
//  fastgi
//
//  Created by Hegaro on 24/11/2020.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI
import CarBode
struct MembershipView: View {
    @State private var action:Int? = 0
    @ObservedObject var afiliacionVM = AfiliacionViewModel()
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    //alerta
    @State var alertState: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var showBtn: Bool? = true
    //
    //barcode generator
    @State var dataString : String = ""
    @State var barcodeType = CBBarcodeView.BarcodeType.barcode128
    @State var rotate = CBBarcodeView.Orientation.up
    @State var barcodeImage: UIImage?
    
    //alert
    @State private var showingAlert = false
    // compartir img
    @State var items : [Any] = []
    @State var sheet = false
    //modal para el monto
    @State var modal = false
    @State var monto = ""
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColorPrimary()
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColorPrimary()], for: .normal)
        self.userDataVM.DatosUser1()
        self.afiliacionVM.verifiAffiliate(id_cobrador: self.userDataVM.user1._id)
        
    }
    
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
    
    var afiliacion: some View {
        ScrollView{
            VStack{
                
                Text("Seleccione servicio")
                    .font(.caption)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.vertical,10)
                HStack{
                    Button(action: {
                        self.action = 1
                    }){
                        HStack(spacing:10){
                            Image("Transport")
                                .resizable()
                                .frame(width:80, height: 80)
                                .padding(10)
                                //Spacer()
                                //.frame(maxWidth:.infinity)
                        }
                        .background(Color("card"))
                        .cornerRadius(10)
                        //.frame(maxWidth:.infinity)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                        
                    }
                    NavigationLink(destination: SlideFormJoinView(user: self.userDataVM.user1, nombreCompleto: "\(self.userDataVM.user1.nombres) \(self.userDataVM.user1.apellidos)" ), tag: 1, selection: self.$action) {
                        EmptyView()
                    }
                }
            }
        }
        .padding()
    }
    
    var vista: some View {
        ScrollView{
            HStack{
                    VStack{
                        self.imageProfile
                        if self.userDataVM.user1.nombres == Optional(""){
                            Text("+591 \(self.userDataVM.user1.telefono)")
                                .bold()
                        }else{
                            Text("\(self.userDataVM.user1.nombres) \(self.userDataVM.user1.apellidos)")
                                .bold()
                        }
                        if self.monto == ""{
                            //barcode
                            CBBarcodeView(data: .constant(self.userDataVM.user1._id) ,
                                          barcodeType: $barcodeType,
                                          orientation: $rotate)
                            { image in
                                self.barcodeImage = image
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .topLeading)
                            
                            Image(uiImage: generarQR(text: self.userDataVM.user1._id))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }else{
                            //barcode
                            CBBarcodeView(data: .constant("\(self.userDataVM.user1._id)\(self.monto)") ,
                                          barcodeType: $barcodeType,
                                          orientation: $rotate)
                            { image in
                                self.barcodeImage = image
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100, alignment: .topLeading)
                            
                            Image(uiImage: generarQR(text: "\(self.userDataVM.user1._id)\(self.monto)"))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        if self.monto != ""{
                            Text("\(self.monto) Bs.")
                                .font(.title)
                        }
                        Text("su afiliaci??n ya fue aprobada")
                    }
            }.padding(30)
        }
    }
    
    var body: some View {
        ScrollView{
            HStack{
                if self.afiliacionVM.afiliacionHabilitacion._id == "" {
                    self.afiliacion
                }else if self.afiliacionVM.afiliacionHabilitacion.habilitado == false{
                    Text("afiliaci??n en progreso")
                }else if self.afiliacionVM.afiliacionHabilitacion.habilitado == true{
                    VStack{
                        self.vista
                        HStack{
                            Button("Monto") {
                                self.modal.toggle()
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
                        }
                    }
                    
                }
                
            }
        }
    }
    
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Su afiliaci??n esta en proceso verifique de algunos minutos por favor."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
        }))
    }
    
}

/*struct MembershipView_Previews: PreviewProvider {
    static var previews: some View {
        MembershipView()
    }
}*/




