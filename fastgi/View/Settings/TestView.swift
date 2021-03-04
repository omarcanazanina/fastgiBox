//
//  TestView.swift
//  fastgi
//
//  Created by Hegaro on 29/01/2021.
//

import SwiftUI
//import SwiftUIPullToRefresh
struct TestView: View {

    @State private var showingAlert1 = false
        @State private var showingAlert2 = false
    
    var body: some View {
        VStack {
                    Button("Show 1") {
                        showingAlert1 = true
                    }
                    .alert(isPresented: $showingAlert1) {
                        Alert(title: Text("One"), message: nil, dismissButton: .cancel())
                    }

                    Button("Show 2") {
                        showingAlert2 = true
                    }
                    .alert(isPresented: $showingAlert2) {
                        Alert(title: Text("Two"), message: nil, dismissButton: .cancel())
                    }
        }
    }
}
