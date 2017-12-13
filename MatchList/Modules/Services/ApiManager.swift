//
//  ApiManager.swift
//  MatchList
//
//  Created by Mauricio Figueroa olivares on 12-12-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    
    // Instanciamos la clase
    let matchs = Matchs()
    
    func loadApiMatchs(page: Int, callback:@escaping (_ matchsList: [Matchs]?, _ message: String, _ error: Bool)->()) {
        // Confirmamos si tenemos conexión a internet
        if Reachability.isConnectedToNetwork(){
            Alamofire.request(getUrlApiForPage(page: page), method: HTTPMethod.get, parameters:nil,encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    // Enviamos los datos a mapear y guardar en CoreData
                    self.matchs.MappingMatchs(dataJson: json)
                    callback(self.matchs.getAllMatchs(),"", false)
                case .failure(let error):
                    callback(nil, "Error al conectarse al Servidor", true)
                }
            }
        } else {
            callback(self.matchs.getAllMatchs(),"", false)
        }
    }
    
}

