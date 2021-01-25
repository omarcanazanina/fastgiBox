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
        
       TextField("Other:" , text: $amounValue)
            .keyboardType(.numberPad)
            .accentColor(.white)
            .foregroundColor(self.amounValue != ""  ? Color.white : Color("normal-text"))
            .frame(maxWidth:.infinity)
            .padding(8)
            .padding(.horizontal)
           // .background(Color.white)
            .background(Color("primary"))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
        
        //
        .introspectTextField { (textField) in
            textField.attributedPlaceholder = NSAttributedString(string: "Other:",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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

struct InputCreditAmountView_Previews: PreviewProvider {
    static var previews: some View {
        InputCreditAmountView(amounValue: .constant(""))
    }
}
