//
//  DetailScreenInteractorMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class DetailScreenInteractorMock: DetailListInteractorProtocol {
    
    var didDetail: (()->())?
    var didFavorite: ((_ location: Location)->())?
    var didSave: ((_ location: Location)->())?
    var didDelete: ((_ location: Location)->())?
    
    func getDetailLocation(with id: Int, completion: @escaping (Result<DetailLocation, Error>) -> ()) {
        if let didDetail = didDetail {
            didDetail()
        }
    }
    
    func checkIfIsFavorite(location: Location, completion: @escaping (Bool) -> ()) {
        if let didFavorite = didFavorite {
            didFavorite(location)
        }
    }
    
    func saveLocation(location: Location) {
        if let didSave = didSave {
            didSave(location)
        }
    }
    
    func deleteLocation(location: Location) {
        if let didDelete = didDelete {
            didDelete(location)
        }
    }
    
    
}
