//
//  FormLoadBoxView.swift
//  fastgi wallet
//
//  Created by Hegaro on 31/03/2021.
//


import SwiftUI
import Introspect

struct FormLoadBoxView: View {

    @State private var action:Int? = 0
    @State var MontoRecarga1: BtnCA
    @State  var MontoRecarga = ""
    //alert
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var alertState: Bool = false
    
    //
    @State var showingSheetBank = false
    @State var bank: String = "Seleccionar"
    var pickerBank: some View{
        Button(action: {
            self.showingSheetBank.toggle()
        }) {
            HStack{
                Text(self.bank)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetBank) {
            ListCardsView(
                showingSheet: self.$showingSheetBank,
                card: self.$bank)
        }
    }
    
    
    var home: some View {
        ScrollView{
            VStack{
                Text("")
                Text("55")
                    .font(.title)
                Text("Saldo")
                    .font(.subheadline)
                VStack(alignment: .leading, spacing: 10){
                    Text("")
                Text("Tarjeta")
                    .textStyle(TitleStyle())
                self.pickerBank
                }
                ContentButtonsView(currentBtn: $MontoRecarga1, text: "", montoRecarga: $MontoRecarga)
                Button(action: {
                    
                }){
                    Text("Aceptar")
                    .foregroundColor(Color.white)
                    .frame(maxWidth:.infinity)
                    .padding(8)
                    .background(Color("primary"))
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    .padding()
                        
                }
                
            }.padding()
        }
    }
    
    var body: some View {
        VStack{
            
                self.home
                    .padding(.leading)
                    .padding(.top,80)
            //}
        }
        .edgesIgnoringSafeArea(.top)
    }
}


struct FormLoadBoxView_Previews: PreviewProvider {
    static var previews: some View {
        FormLoadBoxView(MontoRecarga1: .Btn30)
    }
}
