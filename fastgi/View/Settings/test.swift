//
//  test.swift
//  fastgi
//
//  Created by Hegaro on 12/11/2020.
//

import SwiftUI


struct test: View {

    @State private var number = 0
    @State private var showModal = false

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            number += 1
        }
    }

    var body: some View {
        NavigationView {
            VStack {
              Text("asd")
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        showModal.toggle()
                                    }, label: {
                                        Image(systemName: "ellipsis")
                                            .resizable()
                                            .frame(width: 30, height: 6)
                                            .padding(.trailing,6)
                                    })) .frame(width: 30, height: 30)

            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showModal.toggle()
                    }, label: {
                        Text("Open Modal")
                    })
                }
            }
        }

        .sheet(isPresented: $showModal, content: {
            Text("Hello, World!")
        })

    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
