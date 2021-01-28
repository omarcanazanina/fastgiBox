//
//  testView.swift
//  fastgi
//
//  Created by Hegaro on 26/01/2021.
//

import SwiftUI
import SwiftUIRefresh
struct testView: View {
    let posts = ["dasd","sad"]
       @State private var isShowing = false
    var body: some View {
        List {
            Text("Item 1")
                     Text("Item 2")
                 }.pullToRefresh(isShowing: $isShowing) {
                          self.isShowing = false
                 }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
