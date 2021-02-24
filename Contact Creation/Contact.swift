//
//  Contact.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import Foundation

struct Contact {
    var name: String
    var lastname: String
    var fullName: String{
        get{
            return "\(name) \(lastname)"
        }
    }
    var phoneNumber: String
    var imageURL: String
    
    init(contact: ContactEntity){
        self.name = contact.name ?? ""
        self.lastname = contact.lastName ?? ""
        self.imageURL = contact.imageURL ?? ""
        self.phoneNumber = contact.phoneNumber ?? ""
    }
    
    init(name: String, lastname: String, phoneNumber: String, imageURL: String?){
        self.name = name
        self.lastname = lastname
        self.phoneNumber = phoneNumber
        self.imageURL = imageURL ?? ""
    }
    
}
