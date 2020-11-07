//
//  Helper.swift
//  fastgi
//
//  Created by Hegaro on 06/11/2020.
//

import Foundation
import UIKit
import SwiftUI



//1
/*extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}*/
//2
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//3
/*extension UITextField{
    func addDoneButtonKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x:0, y:0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
   }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
}*/


