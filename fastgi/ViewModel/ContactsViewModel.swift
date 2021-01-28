//
//  ContactsViewModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class ContactsViewModel: ObservableObject {
    
    
    private var disposables: Set<AnyCancellable> = []
    var contactsResponse=Contacts()
    @Published var listContacts : [ContactModel] = []
    @Published var status : Bool = false
    //control update
    @Published var isloading: Bool = false
    @Published var messageError : String = ""
    //carga de la lista
    @Published var listComplete: Bool = false
    
    private var isListContactsPublisher: AnyPublisher<Bool, Never> {
        contactsResponse.$getContactsResponse
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return false
                }
                self.listContacts = response
                self.listComplete = true
                return true
            }
            .eraseToAnyPublisher()
    }
    
    private var isLoadingPublished: AnyPublisher<Bool, Never> {
        contactsResponse.$isloading
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    private var ErrorPublished: AnyPublisher<String, Never> {
        contactsResponse.$messageError
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    
 
    
    init() {
        isListContactsPublisher
             .receive(on: RunLoop.main)
             .assign(to: \.status, on: self)
             .store(in: &disposables)
        
        isLoadingPublished
            .receive(on: RunLoop.main)
            .assign(to: \.isloading, on: self)
            .store(in: &disposables)
        
        ErrorPublished
            .receive(on: RunLoop.main)
            .assign(to: \.messageError, on: self)
            .store(in: &disposables)
        
        getContacts()
    }
    
    
    func getContacts() {
        self.contactsResponse.ListContacts()
        
       }
    
    func updateContacts() {
        contactsResponse.updateContacts()
            
    }
    
}
