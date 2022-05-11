//
//  Location.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//
import CoreData

struct Location: Codable, ModelCoreData {
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong: String
    
    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case locationType = "locationType"
        case woeid = "woeid"
        case lattLong = "lattLong"
    }
    
    static func getEntity() -> String {
        String(describing: FavoriteLocation.self)
    }
    
    func getCoreDataDictionary() -> [String : Any?] {
        return [
            "title": self.title,
            "locationType": self.locationType,
            "woeid": self.woeid,
            "lattLong": self.lattLong
        ]
    }
    
    func getIdentifier() -> Int {
        return woeid
    }
    
    init(title: String, locationType: String, woeid: Int, lattLong: String) {
        self.title = title
        self.locationType = locationType
        self.woeid = woeid
        self.lattLong = lattLong
    }
    
    init(object: NSManagedObject) {
        self.title = object.value(forKey: "title") as? String ?? ""
        self.locationType = object.value(forKey: "locationType") as? String ?? ""
        self.woeid = object.value(forKey: "woeid") as? Int ?? 0
        self.lattLong = object.value(forKey: "lattLong") as? String ?? ""
    }
}

