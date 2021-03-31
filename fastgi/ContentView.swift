//
//  ContentView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showingSheet = false
    var body: some View {
        Button(action: {
               self.showingSheet = true
           }) {
               Text("Share")
           }
           .sheet(isPresented: $showingSheet,
                  content: {
                    ActivityView(activityItems: [self.body.snapshot()] as [Any], applicationActivities: nil) })
       }
    }


/*struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}*/

