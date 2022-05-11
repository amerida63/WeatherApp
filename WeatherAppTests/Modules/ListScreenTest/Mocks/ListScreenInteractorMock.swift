//
//  ListScreenInteractorMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class ListScreenInteractorMock: ListScreenInteractorProtocol {
    var delegate: PresenterToInteractorProtocol?
    var didList: (()->())?
    var didDelete: (()->())?
    var didCache: (()->())?
    
    func getLocations(with text: String, completion: @escaping (Result<[Location], Error>) -> ()) {
        if let didList = didList {
            didList()
        }
    }
    
    func deleteLocation(location: Location) {
    }
    
    func fillLocationsInCache() {
        if let didCache = didCache {
            didCache()
        }
    }
    
    
}
