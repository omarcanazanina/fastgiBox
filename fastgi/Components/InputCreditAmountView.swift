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
            .keyboardType(.numbersAndPunctuation)
            .foregroundColor(Color("normal-text"))
            .frame(maxWidth:.infinity)
            .padding(8)
            .padding(.horizontal)
            .background(Color("input"))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
       }
}

struct InputCreditAmountView_Previews: PreviewProvider {
    static var previews: some View {
        InputCreditAmountView(amounValue: .constant(""))
    }
}
