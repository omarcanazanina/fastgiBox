//
//  EnterAmountView.swift
//  fastgi
//
//  Created by Hegaro on 19/01/2021.
//

import SwiftUI

struct EnterAmountView: View {
    @State private var monto: String = ""
    @State private var action:Int? = 0
    
    var buttonSuccess:some View {
        VStack(){
            Button(action: {
                self.action = 1
            }){
                Text("Aceptar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                
            }
        }.padding()
        
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 8){
                Text("MONTO BS.")
                    .textStyle(TitleStyle())
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
                        textField.becomeFirstResponder()
                     }
            }
            self.buttonSuccess
            NavigationLink(destination: QrGeneratorView(monto: self.monto), tag: 1, selection: self.$action) {
                    EmptyView()
            }
        }.padding()
    }
  
}

struct EnterAmountView_Previews: PreviewProvider {
    static var previews: some View {
        EnterAmountView()
    }
}
