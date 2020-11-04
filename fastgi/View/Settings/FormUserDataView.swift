//
//  FormUserDataView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct FormUserDataView: View {
    var updateUser = UpdateUser()
    @ObservedObject var loginVM = LoginViewModel()
    @State var text: String = ""
    @ObservedObject var login = Login()
    @ObservedObject var updateVM = UpdateUserViewModel()
    var navigationRoot = NavigationRoot()
    // back
    @EnvironmentObject var authState: AuthState
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    //Test
    @State var output: String = ""
    @State var input: String = ""
    //validation
    @State var ci: String = ""
    
    var infoUser:some View{
        ScrollView(){
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 8){
  
                    Text("DATOS PERSONALES")
                        .textStyle(TitleStyle())
                    
                    Text("DOCUMENTO DE IDENTIDAD")
                        .textStyle(TitleStyle())
                    TextField("C.I.", text:  self.$loginVM.user.ci, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                     
                    Text("CORREO ELECTRÓNICO")
                        .textStyle(TitleStyle())
                    TextField("user@email.com", text: self.$loginVM.user.correo, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                    
                    Text("NOMBRES")
                        .textStyle(TitleStyle())
                    TextField("user name", text: self.$loginVM.user.nombres, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                    
                    Text("APELLIDOS")
                        .textStyle(TitleStyle())
                    TextField("user lastname", text: self.$loginVM.user.apellidos, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                    
                }
                VStack(alignment: .leading, spacing: 8){
                    
                    Text("DIRECCIÓN")
                        .textStyle(TitleStyle())
                    TextField("user address", text: self.$loginVM.user.direccion, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                    
                    Divider()
                        .padding(.vertical)
                    
                    Text("DATOS DE FACTURACIÓN")
                        .textStyle(TitleStyle())
                    
                    Text("NOMBRE")
                        .textStyle(TitleStyle())
                    
                    TextField("Nombre", text: self.$loginVM.user.nombrenit, onEditingChanged: { changed in self.AddSpace = false})
                        .textFieldStyle(Input())
                    
                    //.onAppear(perform: {self.IsKeyboardUp(Is: false)})
                    
                    Text("NIT")
                        .textStyle(TitleStyle())
                    
                    TextField("nit", text: self.$loginVM.user.nit, onEditingChanged: { changed in self.AddSpace = false})
                        .textFieldStyle(Input())
                        //.padding(.bottom, self.AddSpace ? 40 : 0)
                    
                    
                    /*Spacer()
                        .frame(height:80)*/
                }
              
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top,.horizontal])
       
        }
        
    }
    
    
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
                self.updateVM.updateUser(ci: self.loginVM.user.ci, correo: self.loginVM.user.correo, nombres: self.loginVM.user.nombres, apellidos: self.loginVM.user.apellidos, direccion: self.loginVM.user.direccion, nombrenit: self.loginVM.user.nombrenit, nit: self.loginVM.user.nit)
                self.authState.navigateBack = true
                self.alertState = true
              
            }){
                Text("Aceptar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
           /* NavigationLink(destination: SettingsView(), tag: "updatesuccess", selection: self.$login.ruta) {
                EmptyView()
            }*/
            if self.updateVM.isloading == true{
                Loader()
            }
        }
        .padding()
    }
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Datos modificados correctamente."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
            
        }))
    }
    @State var valueKeyboard : CGFloat = 0
    @State var AddSpace : Bool = false

    
    func IsKeyboardUp() -> Void{
        //Keyboard is show
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object:nil, queue: .main){
            (noti) in
            let valueKeyboard = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let height = valueKeyboard.height
            
            if self.AddSpace {
                print("Is true")
                print(self.AddSpace)
                //self.valueKeyboard = height-70
                //self.valueKeyboard = height-70
                self.valueKeyboard = height-300
            }else{
                print("Is false")
                self.valueKeyboard = 0
            }
            
            
            //print(Is)
            //self.AddSpace = true
        }
        //Keyboard is hidde
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object:nil, queue: .main){
            (noti) in
            self.valueKeyboard = 0
             //self.AddSpace = false
        }
    }
    
    
    
    
    var body: some View {
        VStack(){
            self.infoUser

            self.buttonSuccess
     //test validacion
     /*   VStack{
         
           
         
            Form {
           Text("DOCUMENTO DE IDENTIDAD")
                    .textStyle(TitleStyle())
                TextField("C.I.", text: self.$update.ci.bound, onEditingChanged: { changed in self.AddSpace = false})
                .textFieldStyle(Input())
                TextField("Correo", text: self.$update.correo.bound)
                TextField("Nombres", text: self.$update.nombres.bound)
                TextField("Apellidos", text: self.$update.apellidos.bound)
                TextField("Direccion", text: self.$update.direccion.bound)
                TextField("NombreNit", text: self.$update.nombrenit.bound)
                TextField("Nit", text: self.$update.nit.bound)
                BrokenRulesView(brokenRules: self.update.brokenRules)
            }
            
        }
        Button("Test Validation") {
            self.update.validationInput()
        }*/
             //

        }
            
        .offset(y: -self.valueKeyboard)
        //.animation(.spring())
            
        .onAppear{
            self.loginVM.DatosUser()
           // self.update.DatosUserUpdate()
            self.IsKeyboardUp()
        }
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
    }
}


struct FormUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        FormUserDataView()
    }
}
