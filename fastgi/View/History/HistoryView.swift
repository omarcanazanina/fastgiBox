//
//  HistoryView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @ObservedObject var recargas = Recargas()
    @State private var optionPicker:Int = 0
    @ObservedObject var RecargaVM = RecargaViewModel()
    //ruta
    //@ObservedObject var login = Login()
    //
    @State private var fecha :String = ""
    @State private var empresa :String = ""
    @State private var phone :String = ""
    @State private var monto :String = ""
    @State private var control : Int = 0
    @State private var action:Int? = 0
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColorPrimary()
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        //UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColorPrimary()], for: .normal)
    }
    let contacts = ["Herlan Garzon", "Omar Canaza", "Elvin Mollinedo", "Agustin Ayaviri", "Daniel Jaimes", "Amilkar Dominguez"]
    @State private var searchText : String = ""
    var list:some View{
        //ScrollView{
        //NavigationView{
        VStack{
            // SearchBar(text: $searchText, placeholder: "Buscar")
            List {
                /*
                 ForEach(self.contacts.filter {
                 self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                 }, id: \.self) { item in
                 **/
                ForEach(self.RecargaVM.ListRecargas, id: \.self._id){ (recarga:RecargaModel) in
                    Button(action: {
                        print(self.RecargaVM.ListRecargas)
                        self.action = 1
                        self.fecha = recarga.fecha
                        print("esta es la fecha\(self.fecha)")
                        self.empresa = recarga.empresa
                        self.phone = recarga.telefono
                        self.monto = recarga.recarga
                    })
                    {
                        HStack(){
                            VStack(){
                                Text(recarga.telefono)
                                    .opacity(0.8)
                                    .font(.caption)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                Text("Tipo")// \(recarga.fecha)")
                                    .font(.caption)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                Text(recarga.telefono)//fecha)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                            }.frame(maxWidth:.infinity, alignment: .leading)
                            Spacer()
                            VStack(){
                                Text("\(recarga.recarga).00 Bs.")
                            }
                            
                        }
                        
                    }
                    
                }
            }
            /* NavigationLink(destination: TransactionDetailView(), tag: "detail", selection: self.$login.ruta) {
             EmptyView()
             }*/
        }.offset(y:-15)
        
        //}
        
        
    }
    
    var listNot:some View{
        //ScrollView{
        VStack{
            SearchBar(text: $searchText, placeholder: "Buscar")
            List {
                ForEach(self.contacts.filter {
                    self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                }, id: \.self) { item in
                    //Item of list
                    Button(action: {
                        //self.RecargaVM.listRecargas()
                        // print(self.RecargaVM.ListRecargas)
                        //self.recargas.ListRecargas()
                    })
                    {
                        HStack(){
                            VStack(){
                                Text(item)
                                    .opacity(0.8)
                                    .font(.caption)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                Text("Tipo")
                                    .font(.caption)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                Text("14/09/2020 16:50")
                                    .frame(maxWidth:.infinity, alignment: .leading)
                            }.frame(maxWidth:.infinity, alignment: .leading)
                            Spacer()
                            VStack(){
                                Text("50.00 Bs.")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    var body: some View {
        VStack {
            VStack{
                Picker(selection: $optionPicker, label: Text("")) {
                    Text("Realizadas").tag(0)
                    Text("No realizadas").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                if(optionPicker==0){
                    self.list
                    NavigationLink(destination: TransactionDetailView(fecha: self.fecha, empresa: self.empresa, phone: self.phone, monto: self.monto, control: 0, fechaFormat: "", horaFormat: ""), tag: 1, selection: self.$action) {
                        EmptyView()
                    }
                }
                if(optionPicker==1){
                    //Text("list no realizadas")
                    self.listNot
                }
            }
            .onAppear{
                self.loginVM.DatosUser()
                self.RecargaVM.listRecargas()
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

