//
//  SettingsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

/*struct SettingsView: View {
    @ObservedObject var login = Login()
    @ObservedObject var loginVM = LoginViewModel()
    //imagen
    // @ObservedObject var image = ImageAvatar()
    @ObservedObject var imageVM = ImageViewModel()
    //test
    // @State private var image : UIImage? = nil
    //back
    @EnvironmentObject var authState: AuthState
    @State var menu : Bool = false
    //camera
    @State private var showImagePicker: Bool = false
    @State private var showSheet:Bool = false
    @State private var imageSelect : UIImage? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    //control del menu
    @State var controlMenu = 3

    //test view
    @State private var number = 0
    @State private var showModal = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColorPrimary()
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColorPrimary()], for: .normal)
    }
    
    var imageProfile:some View {
        HStack(alignment: .center){
                WebImage(url: URL(string: "https://api.fastgi.com/avatar/\(self.loginVM.user._id)" ))
                    .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                //Image(uiImage: self.imageVM.image ?? UIImage(named: "placeholder")!)
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
        .overlay(
            HStack(alignment:.bottom){
                Spacer()
                Button(action: {
                    self.showSheet = true
                    // self.showImagePicker = true
                    // self.sourceType = .photoLibrary
                }){
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("primary"))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("card"), lineWidth: 2))
                    
                }.padding(.top,60)
            }
        )
        .padding(.top)
    }
    
    var infoUser:some View{
        ScrollView(){
            //
            
            //
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 8){
                    
                    Text("DATOS PERSONALES")
                        .textStyle(TitleStyle())
                    HStack{
                        Text("DOCUMENTO DE IDENTIDAD")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.ci)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("CORREO ELECTRÓNICO")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.correo)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("NOMBRES")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.nombres)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("APELLIDOS")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.apellidos)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("DIRECCIÓN")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.direccion)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    Divider()
                    
                    Text("DATOS DE FACTURACIÓN")
                        .textStyle(TitleStyle())
                    HStack{
                        Text("NOMBRE")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.nombrenit)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        
                        Text("NIT")
                            .textStyle(TitleStyle())
                        Text(self.loginVM.user.nit)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                }
                VStack(alignment: .leading, spacing: 8){
                    Divider()
                    /*HStack{
                        
                        Text("MÉTODOS DE PAGO")
                            .textStyle(TitleStyle())
                        
                        
                        Image(systemName: "chevron.right")
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }*/
                    NavigationLink(destination: ListCreditCardView()) {
                        HStack{
                            Image(systemName: "creditcard")
                            Text("MÉTODOS DE PAGO")
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top,.leading])
        
    }
    

    var body: some View {
        NavigationView {
            VStack{
                HStack {
                self.imageProfile
                }
               /* HStack{
                    self.infoUser
                }*/
                .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(leading:
                                        Button(action: {
                                            showModal.toggle()
                                        }, label: {
                                            Image(systemName: "ellipsis")
                                                .resizable()
                                                .frame(width: 30, height: 6)
                                                .padding(.trailing,6)
                                        })) .frame(width: 30, height: 30)

                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            showModal.toggle()
                        }, label: {
                            Text("Open Modal")
                        })
                    }
                }
                
            }
            
        }

        .sheet(isPresented: $showModal, content: {
            Text("Hello, World!")
        })

    }
}*/

struct SettingsView: View {
    
    @ObservedObject var login = Login()
    @ObservedObject var loginVM = LoginViewModel()
    //imagen
    // @ObservedObject var image = ImageAvatar()
    @ObservedObject var imageVM = ImageViewModel()
    
    //test
    // @State private var image : UIImage? = nil
    //back
    @EnvironmentObject var authState: AuthState
    @State var menu : Bool = false
    //camera
    @State private var showImagePicker: Bool = false
    @State private var showSheet:Bool = false
    @State private var imageSelect : UIImage? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    //control del menu
    @State var controlMenu = 3
    
    //datos test
    @ObservedObject var userDataVM = UserDataViewModel()
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColorPrimary()
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColorPrimary()], for: .normal)
    }
    

    var icon:some View {
        HStack{
            HStack{
                Spacer()
                Button(action: {
                    self.menu = true
                    print("menu")
                }){
                    VStack{
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .padding(.trailing,6)
                    }
                    .frame(width: 30, height: 30)
                }
                .buttonStyle(PlainButtonStyle())
            }
            NavigationLink(destination: MenuView(), isActive: $menu) {
                EmptyView()
            }.isDetailLink(false)
        }
    }
    
    var imageProfile:some View {
        HStack(alignment: .center){
                WebImage(url: URL(string: "https://api.fastgi.com/avatar/\(self.loginVM.user._id)" ))
                    .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                //Image(uiImage: self.imageVM.image ?? UIImage(named: "placeholder")!)
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
        .overlay(
            HStack(alignment:.bottom){
                Spacer()
                Button(action: {
                    self.showSheet = true
                    // self.showImagePicker = true
                    // self.sourceType = .photoLibrary
                }){
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("primary"))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("card"), lineWidth: 2))
                    
                }.padding(.top,60)
            }
        )
        .padding(.top)
    }
    
 
    
    var infoUser:some View{
        ScrollView(){
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 8){
                    Text("DATOS PERSONALES")
                        .textStyle(TitleStyle())
                    HStack{
                        Text("DOCUMENTO DE IDENTIDAD")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.ci)
                        //Text(self.loginVM.user.ci)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("CORREO ELECTRÓNICO")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.correo)
                        //Text(self.loginVM.user.correo)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("NOMBRES")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.nombres)
                        //Text(self.loginVM.user.nombres)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("APELLIDOS")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.apellidos)
                        //Text(self.loginVM.user.apellidos)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        Text("DIRECCIÓN")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.direccion)
                        //Text(self.loginVM.user.direccion)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    Divider()
                    
                    Text("DATOS DE FACTURACIÓN")
                        .textStyle(TitleStyle())
                    HStack{
                        Text("NOMBRE")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.nombrenit)
                            //Text(self.loginVM.user.nombrenit)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                    HStack{
                        
                        Text("NIT")
                            .textStyle(TitleStyle())
                        Text(self.userDataVM.user.nit)
                            //Text(self.loginVM.user.nit)
                            .padding(.trailing)
                            .frame(maxWidth:.infinity, alignment: .trailing)
                    }
                }
                VStack(alignment: .leading, spacing: 8){
                    Divider()
                    NavigationLink(destination: ListCreditCardView()) {
                        HStack{
                            Image(systemName: "creditcard")
                            Text("MÉTODOS DE PAGO")
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                        }
                    }
                    NavigationLink(destination: QrGeneratorView()) {
                        HStack{
                            Image(systemName: "qrcode")
                            Text("MI QR")
                                .font(.caption)
                            Image(systemName: "chevron.right")
                                .padding(.trailing)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top,.leading])
        
    }
    
    
    var content:some View{
        VStack{
                ScrollView{
                self.imageProfile
                Spacer()
                    .frame(height:20)
                self.infoUser
                }
        }
}

    
    var body: some View {
            VStack{
                VStack{
                    HStack{
                        self.content
                            .onReceive(self.authState.$navigateBack) { moveToDashboard in
                                if moveToDashboard {
                                    print("Move to dashboard: \(moveToDashboard)")
                                    self.menu = false
                                    self.authState.navigateBack = false
                                }
                            }
                    }
                    .sheet(isPresented: self.$showImagePicker,onDismiss:  {
                        print("ento al sheet")
                        // debugPrint(self.image ?? "")
                        // self.image.uploadAvatar(image: self.imageSelect!)
                        self.imageVM.changeImage()
                        //ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                        print("salio del sheet")
                    })
                    {
                        ImagePicker(image: self.$imageVM.image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                    }
                }
                .actionSheet(isPresented: self.$showSheet) {
                    ActionSheet(title: Text("Opciones"), buttons: [
                        .default(Text("Galeria")) {
                            print("entro galeria")
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        },
                        .default(Text("Camara")) {
                            print("camara")
                            self.showImagePicker = true
                            self.sourceType = .camera
                        },
                        .cancel()
                    ])
                }
            }
    }
}




struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

