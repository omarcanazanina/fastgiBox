//
//  ImageViewModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Combine
import AVKit

class ImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    var imageResponse = ImageAvatar()
    private var disposables: Set<AnyCancellable> = []
    @Published var statusResponse = false
    //storage
    private let storage = UserDefaults.standard
  
    private var isImagePublisher: AnyPublisher<Bool, Never> {
        imageResponse.$image
           .receive(on: RunLoop.main)
           .map { response in
               guard let response = response else {
                   return false
               }
            self.image = response
               return true
       }
       .eraseToAnyPublisher()
   }
    
    init(){
        isImagePublisher
            .receive(on: RunLoop.main)
            .assign(to: \.statusResponse, on: self)
            .store(in: &disposables)
       
    }
    
    func changeImage(){
        print("entro changeImage")
        print(self.image ?? "")
        guard let img = self.image,
              
              let imgData:Data = img.jpegData(compressionQuality: 0.1)
        else {
            print("error")
            return
        }
        imageResponse.uploadAvatar(image: imgData)
        print("salio changeImage")
    }
    
    
    func downloadImage(){
      /*  if let pathImage = self.storage.string(forKey: "userProfile") {
            print("viewModel\(pathImage)")
            self.image = UIImage(contentsOfFile: pathImage)
            print("image view Model\(self.image )")
            //self.statusResponse = true
        }else{*/
            imageResponse.getImage()
       // }
       
    }
}
