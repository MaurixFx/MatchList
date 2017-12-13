//
//  Matchs+CoreDataProperties.swift
//  
//
//  Created by Mauricio Figueroa olivares on 12-12-17.
//
//

import Foundation
import CoreData


extension Matchs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Matchs> {
        return NSFetchRequest<Matchs>(entityName: "Matchs")
    }

    @NSManaged public var id: String?
    @NSManaged public var localTeamName: String?
    @NSManaged public var visitTeamName: String?
    @NSManaged public var localTeamImage: String?
    @NSManaged public var visitTeamImage: String?
    @NSManaged public var localGoals: Int16
    @NSManaged public var visitGoals: Int16
    @NSManaged public var startDate: String?
    @NSManaged public var stadiumName: String?

}
