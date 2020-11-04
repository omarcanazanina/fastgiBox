//
//  BtnsEmView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct BtnsEmView: View {
    @Binding var currentBtnEm: BtnEm
    var body: some View {
        VStack{
            HStack(){
                CardServiceView(logo: "Entel", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Entel)
                CardServiceView(logo: "Viva", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Viva)
                CardServiceView(logo: "Tigo", isSelect: false, currentBtnEm: self.$currentBtnEm, btn: .Tigo)
            }
        }
    }
}

struct BtnsEmView_Previews: PreviewProvider {
    static var previews: some View {
        BtnsEmView(currentBtnEm: .constant(.Tigo))
    }
}
