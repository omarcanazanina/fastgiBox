//
//  PayView.swift
//  fastgi
//
//  Created by Hegaro on 26/11/2020.
//

import SwiftUI

struct PayView: View {
    @State private var test: String = ""
    var monto: String
    var body: some View {
        VStack{
            Text("Ingresamos el monto")
            Text(self.monto)
            Text("MONTO BS.")
            TextField("Ingrese monto", text: $test)
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

        }
        
    }
}

struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        PayView(monto: "")
    }
}
