//
//  Contact+CoreDataProperties.swift
//  
//
//  Created by Hiroshi Melendez on 2/24/21.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var photoURL: String?
    @NSManaged public var phoneNumber: String?

}
