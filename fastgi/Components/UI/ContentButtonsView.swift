//
//  ContentButtonsView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct ContentButtonsView: View {
    @Binding var currentBtn: BtnCA
    var text: String
    @Binding var montoRecarga: String
    var body: some View {
        BtnsView(currentBtn: self.$currentBtn,text: "", montoRecarga: self.$montoRecarga)
        .padding()
    }
}

struct ContentButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentButtonsView(currentBtn: .constant(.Btn30), text: "", montoRecarga: .constant("30"))
    }
}

