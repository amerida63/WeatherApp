//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: (self), comment: "")
    }
    
    func getDateDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date = dateFormatter.date(from: self)
        
        let dateFormattercalendar = DateFormatter()
        dateFormattercalendar.dateFormat = "EEEE"
        return dateFormattercalendar.string(from: date ?? Date())
    }
}
