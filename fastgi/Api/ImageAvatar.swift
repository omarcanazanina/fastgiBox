//
//  ImageAvatar.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI
import AVKit


import SDWebImageSwiftUI

class ImageAvatar: ObservableObject {
    private let tokenKey = "token"
    private let idKey = "usuario._id"
    //image
    @Published var progresState:Double = 0
    //Storage
    private let storage = UserDefaults.standard
    @Published var image: UIImage?
    
    
    func getImage(){
        // creando headers
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
            //let idusu = storage.string(forKey: idKey)!
        }
        //"5f56de014e834e3bc4c02059"
        let idusu = storage.string(forKey: idKey)!
        //  if  idusu != "" {
        guard let url = URL(string: "https://api.fastgi.com/avatar/\(idusu)") else { return }
        DispatchQueue.main.async {
             let destination: DownloadRequest.Destination = { _, _ in
             let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
             let fileURL = documentsURL.appendingPathComponent("\(idusu).jpeg")
             
             return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
         
             }
            //let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            AF.download(url,method: .get,headers: headers, to: destination)
                .downloadProgress { progress in
                    print("Download Progress: \(progress.fractionCompleted)")
                }
                .response { response in
                    print("response")
                    debugPrint(response)
                    
                    
                    if response.error == nil, let imagePath = response.fileURL?.path {
                        print("entro al if api")
                        self.image = UIImage(contentsOfFile: imagePath)
                       // print(self.image ?? "")
                      //  self.storage.set(imagePath, forKey: "userProfile")
                       // print("del api\(imagePath)")
                    }
                    
                }
        }
    }
    
    func uploadAvatar(image: Data){
        print("entro al uploadAvatar")
        debugPrint(image)
        //     isLoading = true
        // creando headers
        var headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        /*let parametros : Parameters = [
         "avatar": image
         ]*/
        if let token = storage.string(forKey: tokenKey){
            headers.add(name: "token", value: token)
        }
        let idusu = storage.string(forKey: idKey)!
        guard let url = URL(string: "https://api.fastgi.com/upload-avatar/\(idusu)") else { return }
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(image, withName: "avatar",fileName: "image.jpg", mimeType: "image/jpeg")
                
            },
            to: url,method: .post, headers:headers)
            .responseDecodable(of:DataImageResponse.self){ (response) in
                //self.isLoading.toggle()
                // self.completeUpdateUserResponse.toggle()
                debugPrint(response)
            }
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted * 100)")
                self.progresState = progress.fractionCompleted * 100
            }
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
        }
    }
    
}
