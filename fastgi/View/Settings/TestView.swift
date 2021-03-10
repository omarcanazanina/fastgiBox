//
//  TestView.swift
//  fastgi
//
//  Created by Hegaro on 29/01/2021.
//

import SwiftUI
//import SwiftUIPullToRefresh
struct TestView: View {
    
    @State private var email = ""
    
    var body: some View {
        VStack {
                   TextField("email", text: $email)
                 
              
        }
        }
    }


func generateBarCode(_ string: String) -> UIImage {
        
        if !string.isEmpty {
            
            let data = string.data(using: String.Encoding.ascii)
            
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            // Check the KVC for the selected code generator
            filter?.setValue(data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let output = filter?.outputImage?.transformed(by: transform)
            
            return UIImage(ciImage: output!)
        } else {
            return UIImage()
        }
  }
