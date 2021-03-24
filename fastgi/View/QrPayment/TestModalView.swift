//
//  TestModalView.swift
//  fastgi wallet
//
//  Created by Hegaro on 12/03/2021.
//

import SwiftUI

struct TestModalView: View {
    @Binding var modal:Bool
    @State private var email = ""
    var body: some View {
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

struct TestModalView_Previews: PreviewProvider {
    static var previews: some View {
        TestModalView(modal: .constant(false))
    }
}
