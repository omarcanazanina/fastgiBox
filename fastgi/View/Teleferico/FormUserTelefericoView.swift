//
//  FormUserTelefericoView.swift
//  fastgi wallet
//
//  Created by Hegaro on 30/03/2021.
//


import SwiftUI

struct FormUserTelefericoView: View {
    var updateUser = UpdateUser()
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
    //datos user
    @ObservedObject var userDataVM = UserDataViewModel()
    //testvalidation
    @ObservedObject var validationVM = ValidationViewModel()
    init() {
        self.userDataVM.DatosUser1()
        //  self.afiliacionVM.verifiAffiliate(id_cobrador: self.userDataVM.user._id)
    }
    
    var infoUser:some View{
        ScrollView(){
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading, spacing: 8){
                    /*EntryField(sfSymbolName: "envelope", placeHolder: "Name", prompt: validationVM.namePrompt, field: .constant(self.userDataVM.user1.nombres))*/
                    Text("DATOS PERSONALES")
                        .textStyle(TitleStyle())
                    Text("NOMBRES")
                        .textStyle(TitleStyle())
                    TextField("user name", text: self.$userDataVM.user1.nombres, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                    Text("APELLIDOS")
                        .textStyle(TitleStyle())
                    TextField("user lastname", text: self.$userDataVM.user1.apellidos, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.alphabet)
                    Text("NUMERO CELULAR")
                        .textStyle(TitleStyle())
                    TextField("phone", text: self.$userDataVM.user1.telefono, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.numberPad)
                    
                    Text("CORREO ELECTRÓNICO")
                        .textStyle(TitleStyle())
                    TextField("user@email.com", text: self.$userDataVM.user1.correo, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.emailAddress)
                   
                }
                VStack(alignment: .leading, spacing: 8){
                    Text("NIT")
                        .textStyle(TitleStyle())
                    TextField("phone", text: self.$userDataVM.user1.nit, onEditingChanged: { changed in self.AddSpace = false})
                    .textFieldStyle(Input())
                        .keyboardType(.numberPad)
                }
               
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.top,.horizontal])
       
        }
        
    }
    
    
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
                /*self.updateVM.updateUser(ci: self.userDataVM.user1.ci, correo: self.userDataVM.user1.correo, nombres: self.userDataVM.user1.nombres, apellidos: self.userDataVM.user1.apellidos, direccion: self.userDataVM.user1.direccion, nombrenit: self.userDataVM.user1.nombrenit, nit: self.userDataVM.user1.nit)
                //self.authState.navigateBack = true
                self.alertState = true*/
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
            self.navigationRoot.setRootView()
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
        }
            
        .offset(y: -self.valueKeyboard)
        //.animation(.spring())
            
        .onAppear{
            self.userDataVM.DatosUser()
            self.IsKeyboardUp()
        }
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
    }
}


struct FormUserTelefericoView_Previews: PreviewProvider {
    static var previews: some View {
        FormUserTelefericoView()
    }
}
