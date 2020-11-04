//
//  ContactsResponse.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

struct ContactsResponse : Codable{
    let ok : Bool
    let contacto : [ContactModel]
}

struct CreateContactsResponse : Codable{
    let ok : Bool
    let contacto : ContactModel
}

