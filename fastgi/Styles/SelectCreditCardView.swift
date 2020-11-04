//
//  SelectCreditCardView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct SelectCreditCardView: View {
    var body: some View {
        VStack{
            ScrollView(.horizontal)
            {
                HStack{
                    CreditCardView(logo: "visa", bank: "Banco BNB", dateExp: "27/08", number: "1234")
                    CreditCardView(logo: "mastercard")
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                }
                .padding()
              
            }.frame(alignment:.topLeading)

            NavigationLink(destination: FormCreditCardView()) {
             Text("+ Agregar tarjeta")
                 .foregroundColor(Color("primary"))
            }
            
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment:.topLeading)
        .navigationBarTitle("Tarjeta", displayMode: .inline)
    }
}

struct SelectCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCreditCardView()
    }
}


