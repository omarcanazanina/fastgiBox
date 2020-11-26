//
//  InputCreditAmountView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct InputCreditAmountView: View {
       @Binding var amounValue: String
       var body: some View {
        
       TextField("Otro:", text: $amounValue)
            .keyboardType(.numberPad)
            .foregroundColor(Color("normal-text"))
            .frame(maxWidth:.infinity)
            .padding(8)
            .padding(.horizontal)
            .background(Color("input"))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
        
        //
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

struct InputCreditAmountView_Previews: PreviewProvider {
    static var previews: some View {
        InputCreditAmountView(amounValue: .constant(""))
    }
}
