//
//  TestView.swift
//  fastgi wallet
//
//  Created by Hegaro on 24/03/2021.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Home()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct Home : View{
    @State var items : [Any] = []
    @State var sheet = false
    
    var body: some View{
        VStack{
            Button(action: {
                items.removeAll()
                items.append(UIImage(named: "Up")!)
                sheet.toggle()
            }) {
                Text("Share")
                    .fontWeight(.heavy)
            }
            .sheet(isPresented: $sheet, content: {
                ShareSheet(items: items)
            })
            //opcion 2
            Button(action: actionSheet) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 36, height: 36)
                        }
          
        }
    }
    func actionSheet() {
           guard let urlShare = URL(string: "https://developer.apple.com/xcode/swiftui/") else { return }
           let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
       }
    
}

// share
struct ShareSheet1 : UIViewControllerRepresentable {
    var items : [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

