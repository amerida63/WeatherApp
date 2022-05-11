//
//  RenderLocation.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import Foundation

struct RenderLocation: Codable {
    let title: String?
    let consolidatedWeather: ConsolidatedWeather?
    let otherDates: [ConsolidatedWeather]?
}
