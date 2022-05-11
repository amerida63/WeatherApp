//
//  Constants.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation

struct Constants {
    struct Url {
        static let base = "https://www.metaweather.com"
        static let search = "/api/location/search/?query=%@"
        static let detail = "/api/location/%@"
        static let image = "/static/img/weather/png/%@.png"
    }
    
    static let baseImageUrl: String = {
        return Constants.Url.base + Constants.Url.image
    }()
}
