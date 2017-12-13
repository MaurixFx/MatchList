//
//  Matchs+CoreDataClass.swift
//  
//
//  Created by Mauricio Figueroa olivares on 12-12-17.
//
//

import Foundation
import CoreData
import SwiftyJSON


public class Matchs: NSManagedObject {

    var managedContext: NSManagedObjectContext!
    
    func MappingMatchs(dataJson: JSON) {
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            managedContext = container.viewContext
        }
        // Recorremos cada noticia y la vamos agregando
        for result in dataJson["items"].arrayValue {
            // Preguntamos si la historia existe, si no la agregamos
            let idMatch = result["uuid_s"].string ?? ""
            let fetch: NSFetchRequest<Matchs> = Matchs.fetchRequest()
            fetch.predicate = NSPredicate(format: "id = %@", idMatch)
            do {
                let results = try managedContext.fetch(fetch)
                // Si no existe y no fue eliminada la guardamos
                if results.count == 0 {
                    // Declaramos la entidad de Usuario
                    let match = Matchs(context: managedContext)
                    match.id = result["uuid_s"].string ?? ""
                    match.localTeamName = result["local_team_name_s"].string ?? ""
                    match.visitTeamName = result["visit_team_name_s"].string ?? ""
                    match.localTeamImage = result["local_team_image_team-icon_url_s"].string ?? ""
                    match.visitTeamImage = result["visit_team_image_team-icon_url_s"].string ?? ""
                    match.stadiumName = result["stadium_name_s"].string ?? ""
                    match.startDate = result["start_time_dt"].string ?? ""
                    match.localGoals = result["local_goals_i"].int16 ?? 0
                    match.visitGoals = result["visit_goals_i"].int16 ?? 0
                    try managedContext.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllMatchs() -> [Matchs]? {
        // Obtenemos el persistentContainer desde el AppDelegate
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            managedContext = container.viewContext
        }
        var matchsList: [Matchs]?
        let fetch: NSFetchRequest<Matchs> = Matchs.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))]
        do{
            // Obtenemos el resultado
            matchsList = try managedContext.fetch(fetch)
        } catch {
            print(error.localizedDescription)
        }
        return matchsList
    }
    
}
