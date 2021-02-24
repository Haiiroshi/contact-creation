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
    var photoURL: URL?
}
