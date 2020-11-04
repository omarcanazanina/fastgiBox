//
//  ImageModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct DataImage : Codable {
    var name: String
    var mimetype: String
    var size: Int
}

struct GetImage : Codable {
    var size: Int
}
