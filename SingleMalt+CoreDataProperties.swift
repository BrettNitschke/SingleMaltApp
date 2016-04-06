//
//  SingleMalt+CoreDataProperties.swift
//  SingleMaltApp
//
//  Created by Brett Nitschke on 1/26/16.
//  Copyright © 2016 Brett Nitschke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SingleMalt {

    @NSManaged var age: String?
    @NSManaged var date: NSTimeInterval
    @NSManaged var image: NSData?
    @NSManaged var name: String?
    @NSManaged var peat: Bool
    @NSManaged var price: String?
    @NSManaged var score: String?
    @NSManaged var grade: Int32

}
