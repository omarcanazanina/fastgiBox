//
//  PayScanView.swift
//  fastgi wallet
//
//  Created by Hegaro on 16/03/2021.
//

//despues de scan del modulo morado
import SwiftUI
import SDWebImageSwiftUI

struct PayScanView: View {
    var dataUserPay: UpdateUserPagoModel
    @State private var monto: String = ""
    //
    @Binding var montoPagoQR : String
    @State private var action:Int? = 0
    //
    //
    @State var showingSheetBank = false
    @State var bank: String = "Seleccionar"
    @State private var showingSheet = false
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
    
    
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
                self.action = 1
            }){
                Text("Cobrar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
            if self.montoPagoQR == "" {
                NavigationLink(destination: TransactionDetailChargePayView(fecha: "", hora: "", empresa: "cobro", phone: "", monto: self.monto, control: 1, fechaFormat: "", horaFormat: "") , tag: 1, selection: self.$action) {
                    EmptyView()
                }
            }else{
                NavigationLink(destination: TransactionDetailChargePayView(fecha: "", hora: "", empresa: "cobro", phone: "", monto: self.montoPagoQR, control: 1, fechaFormat: "", horaFormat: "") , tag: 1, selection: self.$action) {
                    EmptyView()
                }
            }
            
        }
        .padding()
      
        
    }
    var pickerCard: some View{
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
            ListCardsView(
                showingSheet: self.$showingSheetBank,
                card: self.$bank)
        }
    }
    
    
    
    var pay: some View {
        VStack{
            Text("Pagar")
                .font(.title)
            self.imageProfile
            if self.dataUserPay.nombres == Optional(""){
                Text("+591 \(self.dataUserPay.telefono)")
            }else{
                Text("\(self.dataUserPay.nombres) \(self.dataUserPay.apellidos)")
            }
            VStack(alignment: .leading, spacing: 8){
                Text("")
                Text("MONTO BS.")
                    .textStyle(TitleStyle())
                if self.montoPagoQR == ""{
                    TextField("Ingrese monto", text: $monto)
                        .textFieldStyle(Input())
                        .keyboardType(.decimalPad)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                            doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                            //textField.becomeFirstResponder()
                        }
                }else{
                    TextField("Ingrese monto", text: $montoPagoQR)
                        .textFieldStyle(Input())
                        .keyboardType(.decimalPad)
                        .introspectTextField { (textField) in
                            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                            let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                            let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                            doneButton.tintColor = .darkGray
                            toolBar.items = [flexButton, doneButton]
                            toolBar.setItems([flexButton, doneButton], animated: true)
                            textField.inputAccessoryView = toolBar
                            //textField.becomeFirstResponder()
                        }
                }
              
            }.padding()
            Text("Tarjetas")
                .textStyle(TitleStyle())
            self.pickerCard
            
            
            self.buttonSuccess
            
        }
    }
    
    var body: some View {
        VStack{
            self.pay
        }
    }
}

/*struct PayScanView_Previews: PreviewProvider {
    static var previews: some View {
        PayScanView()
    }
}*/
