//
//  Constant.swift
//  MatchList
//
//  Created by Mauricio Figueroa olivares on 11-12-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import UIKit

let URL_ENDPOINT = "http://futbol.masfanatico.cl/api/u-chile/match/in_competition/transicion2017"
let COLOR_PRINCIPAL = UIColor.HexToColor(hexString: "#66BFBF", alpha: 1)
let COLOR_TEXT = UIColor.HexToColor(hexString: "#EAF6F6", alpha: 1)
let COLOR_GOALS = UIColor.HexToColor(hexString: "#F76B8A", alpha: 1)
let COLOR_SEPARATOR_VIEW = UIColor.HexToColor(hexString: "#F3F3F3", alpha: 1)


func getURLBaseApi() -> String {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
        return dict["URL_API"] as! String
    }
    return ""
}

func getUrlApiForPage(page: Int) -> String {
    return getURLBaseApi() + "?p=\(page)"
}

func getTextoFTime(hour: Int, minutes: Int) -> String {
    let min = minutes == 0 ? "00" : "\(minutes)"
    return "\(hour):\(min) hrs"
}

func getTextOfMonth(month: Int) -> String {
    switch month {
    case 1:
        return "de Enero"
    case 2:
        return "de Febrero"
    case 3:
        return "de Marzo"
    case 4:
        return "de Abril"
    case 5:
        return "de Mayo"
    case 6:
        return "de Junio"
    case 7:
        return "de Julio"
    case 8:
        return "de Agosto"
    case 9:
        return "de Septiembre"
    case 10:
        return "de Octubee"
    case 11:
        return "de Noviembre"
    case 12:
        return "de Diciembre"
    default:
        break
    }
    return ""
}

func getTitleEvent(localName: String, visitName: String) -> String {
    return "\(localName) VS \(visitName)"
}

func getDateStart(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter.date(from: date)!
}

func isSmallPhone() -> Bool {
    return UIScreen.main.bounds.size.height < 667
}

public extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func HexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
}
