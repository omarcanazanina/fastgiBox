//
//  SildeFormJoinView.swift
//  fastgi
//
//  Created by Amilkar on 12/4/20.
//

import SwiftUI

struct SlideFormJoinView: View {
    @ObservedObject var userDataVM = UserDataViewModel()
    @ObservedObject var afiliacionVM = AfiliacionViewModel()
    var navigationRoot = NavigationRoot()
    //@State private var nombreCompletoUser: String = ""
    @State private var inputText: String = ""
    var isSelect:Bool? = true
    @State private var move:CGFloat = UIScreen.main.bounds.width
    @State private var optionSlide:Int = 1
    //datos
    @State private  var numeroCta = ""
    @State private  var placa = ""
    
    //alerta
    @State var alertState: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    func next() {
        if self.move == (UIScreen.main.bounds.width*(-1)){return}
        else{
            self.move = self.move-UIScreen.main.bounds.width
            self.optionSlide+=1
        }
    }
    func previus() {
        if self.move == UIScreen.main.bounds.width{return}
        else{
            self.move = self.move+UIScreen.main.bounds.width
            self.optionSlide-=1
        }
    }
    @State var showingSheetBank = false
    @State var bank: String = "Seleccionar"
    var pickerBank: some View{
        Button(action: {
            self.showingSheetBank.toggle()
        }) {
            HStack{
                Text(self.bank)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetBank) {
            ListBankView(
                showingSheet: self.$showingSheetBank,
                bank: self.$bank)
        }
    }
    var slide1:some View{
        VStack{
            VStack(alignment: .leading, spacing: 10){
                Text("DATOS BANCARIOS")
                    .textStyle(TitleStyle())
                Text("TITULAR")
                    .textStyle(TitleStyle())
                TextField("Titular", text: self.$userDataVM.user.nombres)
                    .textFieldStyle(Input())
                Text("BANCO")
                    .textStyle(TitleStyle())
                self.pickerBank
                Text("NUMERO DE CUENTA")
                    .textStyle(TitleStyle())
                TextField("Nro. de cuenta", text: $numeroCta)
                    .textFieldStyle(Input())
                    .keyboardType(.numberPad)
                    .introspectTextField { (textField) in
                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                        let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                     doneButton.tintColor = .darkGray
                        toolBar.items = [flexButton, doneButton]
                        toolBar.setItems([flexButton, doneButton], animated: true)
                        textField.inputAccessoryView = toolBar
                     }
            }.padding()
            Spacer()
        }.frame(width: UIScreen.main.bounds.width)
    }
    @State var showingSheetCIType = false
    @State var CIType: String = "Seleccionar"
    var pickerCIType: some View{
        Button(action: {
            self.showingSheetCIType.toggle()
        }) {
            HStack{
                Text(self.CIType)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetCIType) {
            ListCITypeView(
                showingSheet: self.$showingSheetCIType,
                CIType: self.$CIType)
        }
    }
    var slide2:some View{
        VStack{
            VStack(alignment: .leading, spacing: 10){
                Text("DATOS AFILIADO")
                    .textStyle(TitleStyle())
                Text("NOMBRE COMPLETO")
                    .textStyle(TitleStyle())
                TextField("Nombre completo", text: self.$userDataVM.user.nombres)
                    .textFieldStyle(Input())
                Text("DOCUMENTO DE IDENTIDAD")
                    .textStyle(TitleStyle())
                HStack{
                    TextField("Nro. Documento", text: self.$userDataVM.user.ci)
                        .textFieldStyle(Input())
                        .keyboardType(.numberPad)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                         doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                         }
                    self.pickerCIType
                }
                Text("CORREO ELECTRÓNICO")
                    .textStyle(TitleStyle())
                TextField("Correo electrónico", text: self.$userDataVM.user.correo)
                    .textFieldStyle(Input())
            }.padding()
            Spacer()
        }.frame(width: UIScreen.main.bounds.width)
    }
    @State var showingSheetTransportType = false
    @State var transportType: String = "Seleccionar"
    var pickerTransportType: some View{
        Button(action: {
            self.showingSheetTransportType.toggle()
        }) {
            HStack{
                Text(self.transportType)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetTransportType) {
            ListTransportTypeView(
                showingSheet: self.$showingSheetTransportType,
                transportType: self.$transportType
            )
        }
    }
    var slide3:some View{
        VStack{
            VStack(alignment: .leading, spacing: 10){
                Text("DATOS SERVICIO TRANSPORTE")
                    .textStyle(TitleStyle())
                Text("TIPO DE SERVICIO")
                    .textStyle(TitleStyle())
                self.pickerTransportType
                Text("PLACA")
                    .textStyle(TitleStyle())
                TextField("Placa", text: $placa)
                    .textFieldStyle(Input())
            }.padding()
            Spacer()
        }.frame(width: UIScreen.main.bounds.width)
    }
    var indicator1:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var indicator2:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color.secondary)
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color.secondary)
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var indicator3:some View{
        HStack(spacing:0){
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("1"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("2"))
                .foregroundColor(.white)
            Rectangle()
                .fill(Color("primary"))
                .frame(width: 80, height: 5)
            Circle()
                .fill(Color("primary"))
                .frame(width: 40, height: 40)
                .overlay(Text("3"))
                .foregroundColor(.white)
        }
    }
    var buttons1:some View{
        HStack{
            Spacer()
                .frame(maxWidth:150)
                .padding(12)
              
            Text("Siguiente")
                .frame(maxWidth:150)
                .padding(12)
                .foregroundColor(.white)
                .background(Color("primary"))
                .clipShape(Capsule())
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.next()
                    }
                    
                }
        }
    }
    var buttons2:some View{
        HStack{
            Text("Anterior")
                .foregroundColor(Color("primary"))
                .padding(12)
                .frame(maxWidth:150)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color("primary"), lineWidth: 1))
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.previus()
                    }
                }
            Text("Siguiente")
                .frame(maxWidth:150)
                .padding(12)
                .foregroundColor(.white)
                .background(Color("primary"))
                .clipShape(Capsule())
                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.next()
                    }
                }
        }
    }
    var buttons3:some View{
        HStack{
            Text("Anterior")
                .foregroundColor(Color("primary"))
                .padding(12)
                .frame(maxWidth:150)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color("primary"), lineWidth: 1))

                .onTapGesture {
                    withAnimation(Animation.spring()){
                        self.previus()
                    }
                }
            
           /* Button(action: {
                print("presiono Aceptar ****************************")
            }){
                Text("Aceptar")
                    .frame(maxWidth:150)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(Animation.spring()){
                            self.next()
                        }
                    }
            }*/
            Button(action: {
                print("presiono Aceptar ****************************")
                print("el banco es \(self.bank)")
                print("el numero de cuenta es \(self.numeroCta)")
                print("el numero de cuenta es \(self.transportType)")
                print("el numero de placa es \(self.placa)")
                self.afiliacionVM.registerAffiliate(nombrebanco: self.bank, numerocuenta: self.numeroCta, tiposervicio: self.transportType, placa: self.placa)
                self.alertState = true
            }){
                Text("Aceptar")
                    .frame(maxWidth:150)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    //.onTapGesture {
                      //  withAnimation(Animation.spring()){
                        //    self.next()
                        //}
                    //}
            }
            if self.afiliacionVM.isloading == true{
                //Loader()
            }
        }
    }
    
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Su afiliación esta en proceso verifique de algunos minutos por favor."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
            self.navigationRoot.setRootView()
        }))
    }
    
    var body: some View {
        VStack{
            VStack{
                if self.optionSlide == 1
                {
                    indicator1
                        .animation(.linear)
                }
                if self.optionSlide == 2
                {
                    indicator2
                        .animation(.linear)
                }
                if self.optionSlide == 3
                {
                    indicator3
                        .animation(.linear)
                }
            }.padding(.top,10)
            Spacer()
            HStack(spacing:0){
                slide1
                slide2
                slide3
            }.offset(x: self.move)
            .animation(.linear)
            Spacer()
            VStack{
                if self.optionSlide == 1
                {
                    buttons1
                        .animation(.linear)
                }
                if self.optionSlide == 2
                {
                    buttons2
                        .animation(.linear)
                }
                if self.optionSlide == 3
                {
                    buttons3
                        .animation(.linear)
                }
            }.padding(.bottom,10)
            
        }.onAppear{
            self.userDataVM.DatosUser()
        }.alert(isPresented:  self.$alertState){
            self.alerts
        }
    }
}

struct SlideFormJoinView_Previews: PreviewProvider {
    static var previews: some View {
        SlideFormJoinView()
    }
}
