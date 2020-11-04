//
//  ImageResponse.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//
import Foundation

struct DataImageResponse : Codable {
    let status : Bool
    let message : String
    let data: DataImage
}

struct GetImageResponse : Codable {
    let data: GetImage
}

struct ErrorUploadImage:Codable {
    var status: Bool
    var message: String
}
