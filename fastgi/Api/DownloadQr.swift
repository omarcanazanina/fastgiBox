//
//  DownloadQr.swift
//  fastgi wallet
//
//  Created by Hegaro on 18/03/2021.
//

import Foundation
import SwiftUI
import Combine

class DownloadQr: ObservableObject {
    func saveImage(image : UIImage) {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: image)
    }
    
    class ImageSaver: NSObject {
        func writeToPhotoAlbum(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
        }
        
        @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            print("Save finished!")
        }
    }
    
}
