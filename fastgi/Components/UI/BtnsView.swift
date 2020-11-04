//
//  BtnsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct BtnsView: View {
    @Binding var currentBtn: BtnCA
     var text : String
    @Binding var montoRecarga : String
    var body: some View {
        VStack(spacing:1){
            HStack{
                ButtonCreditAmountView(text: "10 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn10)
                    .padding()
                ButtonCreditAmountView(text: "20 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn20)
                .padding()
            }
            HStack{
                ButtonCreditAmountView(text: "30 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn30)
                .padding()
                ButtonCreditAmountView(text: "50 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn50)
                .padding()
            }

            HStack{
                ButtonCreditAmountView(text: "100 Bs.", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .Btn100)
                .padding()
                
                if currentBtn != .BtnOther{
                    ButtonCreditAmountView(text: "Other", montoRecarga: self.$montoRecarga, currentBtn: self.$currentBtn, btn: .BtnOther)
                    .padding()
                }
                else{
                    InputCreditAmountView(amounValue: self.$montoRecarga)
                    .padding()
                    
                }
                
               
            }
            
        }
    }
}

struct BtnsView_Previews: PreviewProvider {
    static var previews: some View {
        BtnsView(currentBtn: .constant(.Btn10),text: "", montoRecarga: .constant("10"))
    }
}



