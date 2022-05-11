//
//  DetailLocation.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation

// MARK: - DetailLocation
struct DetailLocation: Codable {
    let consolidatedWeather: [ConsolidatedWeather]?
    let time: String?
    let sunRise: String?
    let sunSet: String?
    let timezoneName: String?
    let parent: Parent?
    let sources: [Source]?
    let title, locationType: String?
    let woeid: Int
    let lattLong, timezone: String?
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Codable {
    let id: Int?
    let weatherStateName: String?
    let weatherStateAbbr: String?
    let windDirectionCompass: String?
    let created: String?
    let applicableDate: String?
    let minTemp, maxTemp, theTemp, windSpeed: Double?
    let windDirection, airPressure: Double?
    let humidity: Int?
    let visibility: Double?
    let predictability: Int?
}

// MARK: - Parent
struct Parent: Codable {
    let title: String?
    let locationType: String?
    let woeid: Int?
    let lattLong: String?
}

// MARK: - Source
struct Source: Codable {
    let title: String?
    let slug: String?
    let url: String?
    let crawlRate: Int?
}
