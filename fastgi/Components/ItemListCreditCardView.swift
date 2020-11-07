//
//  ItemListCreditCardView.swift
//  fastgi
//
//  Created by Amilkar on 11/6/20.
//

import SwiftUI

struct ItemListCreditCardView: View {
    var logo : String? = "fastgi_white"
    var body: some View {
        HStack{
            Image(self.logo!)
                .resizable()
                .scaledToFit()
                .frame(width:65, height: 30)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
            VStack{
                Text("**** 0356")
                    .kerning(4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("09/22")
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ItemListCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListCreditCardView()
    }
}
