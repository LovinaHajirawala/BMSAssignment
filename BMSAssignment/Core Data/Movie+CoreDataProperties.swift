//
//  Movie+CoreDataProperties.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 23/05/21.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieName: [String]?

}

extension Movie : Identifiable {

}
