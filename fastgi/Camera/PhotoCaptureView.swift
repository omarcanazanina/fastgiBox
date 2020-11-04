//
//  PhotoCaptureView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct PhotoCaptureView: View {
    @Binding var showImagePicker :Bool
    @Binding var image :UIImage?
    
    var body: some View {
        ImagePicker(image: $image, isShown: $showImagePicker)
    }
}

struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), image: .constant(UIImage(contentsOfFile: "")))
    }
}
