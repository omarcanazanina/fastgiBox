//
//  TestView.swift
//  fastgi
//
//  Created by Hegaro on 29/01/2021.
//

import SwiftUI
import SwiftUIPullToRefresh
struct TestView: View {

    
    
    var body: some View {
        RefreshableNavigationView(title: "", action:{
            print("test finish")
        }){
            Text("test")
            Divider()
        }
    }
}
