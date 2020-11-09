//
//  ButtonCreditAmountView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//


import SwiftUI

//Enum para botones
enum BtnCA {
    case Btn10
    case Btn20
    case Btn30
    case Btn50
    case Btn100
    case BtnOther
}

struct ButtonCreditAmountView: View {
    var text : String
    @Binding var montoRecarga : String
    @Binding var currentBtn: BtnCA
    let btn: BtnCA
    var body: some View {
        Button(action: {
            self.currentBtn = self.btn
            if self.currentBtn  == .Btn10 {
                self.montoRecarga = "10"
            }; if self.currentBtn  == .Btn20 {
                self.montoRecarga = "20"
            }; if self.currentBtn  == .Btn30 {
                self.montoRecarga = "30"
            }; if self.currentBtn  == .Btn50 {
                self.montoRecarga = "50"
            }; if self.currentBtn  == .Btn100 {
                self.montoRecarga = "100"
            };  if self.currentBtn  == .BtnOther {
                self.montoRecarga = ""
            }
        })
        {
            
            Text(text)
                .foregroundColor(self.currentBtn == btn ? Color.white : Color("normal-text"))
                .frame(maxWidth:.infinity)
                .padding(8)
                .background(self.currentBtn == btn ? Color("primary") : Color("input"))
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
        }
        //.onTapGesture { self.currentBtn = self.btn }
    }
}

struct ButtonCreditAmountView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCreditAmountView(text: "", montoRecarga: .constant("10"), currentBtn: .constant(.Btn10), btn: .Btn10)
    }
}
