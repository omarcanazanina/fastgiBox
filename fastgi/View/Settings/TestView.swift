//
//  TestView.swift
//  fastgi
//
//  Created by Hegaro on 29/01/2021.
//

import SwiftUI
import SwiftUIX
struct TestView: View {
    var navigationRoot = NavigationRoot()
    @State private var email = ""
    
    var body: some View {
        VStack {
            CocoaTextField("Confirmation Code", text: $email)
              //  .isFirstResponder(true)
            
            Button(action: {
                self.navigationRoot.setRootView()
            }){
            Text("prueba")
            }
            
            VStack {
                TextField("Ingrese monto", text: $email)
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
        }
    }

}
