//
//  ListCreditCardView.swift
//  fastgi
//
//  Created by Amilkar on 11/6/20.
//

import SwiftUI

struct ListCreditCardView: View {
    @State private var cards = ["mastercard", "visa", "mastercard", "visa", "visa"]
    var body: some View {
        VStack{
            //NavigationView {
                List {
                    ForEach(cards, id: \.self) { card in
                        //Text(card)
                        ItemListCreditCardView(logo: card)
                    }
                    .onDelete(perform: self.deleteRow)
                    
                    NavigationLink(destination: FormCreditCardView()) {
                     Text("+ Agregar tarjeta")
                         .foregroundColor(Color("primary"))
                    }
                }
                
            //}


            
        }.navigationBarTitle(Text("Mis tarjetas"), displayMode: .inline)
        
    }
    private func deleteRow(at indexSet: IndexSet) {
          self.cards.remove(atOffsets: indexSet)
      }
}

struct ListCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCreditCardView()
    }
}
