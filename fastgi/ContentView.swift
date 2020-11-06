//
//  ContentView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import SwiftUIRefresh

struct ContentView: View {
    
    @State private var isShowing = false
    var body: some View {
        List {
            Text("Item 1")
            Text("Item 2")
        }
        .pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isShowing = false
                print("cargo")
            }
        }
    }
}
