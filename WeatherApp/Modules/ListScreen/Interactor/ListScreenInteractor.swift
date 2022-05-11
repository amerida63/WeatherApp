//
//  ListScreenInteractor.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation

protocol ListScreenInteractorProtocol: AnyObject {
    var delegate: PresenterToInteractorProtocol? { get set }
    func getLocations(with text: String, completion: @escaping(_ response: Result<[Location], Error>) -> ())
    func deleteLocation(location: Location)
    func fillLocationsInCache()
}

final class ListScreenInteractor: ListScreenInteractorProtocol {
    weak var delegate: PresenterToInteractorProtocol?
    var locations: [Location] = []
    let service = ListScreenService()

    func getLocations(with text: String, completion: @escaping (Result<[Location], Error>) -> ()) {
        service.searchLocations(with: text) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    func deleteLocation(location: Location) {
        DispatchQueue.main.async {
            APICoreDataService.shared.deleteObject(location)
        }
    }
    
    private func getFavoritesLocations() -> [Location] {
        let Locations = APICoreDataService.shared.retrieve(Location.self)
        return Locations
    }
    
    func fillLocationsInCache() {
        DispatchQueue.main.async {
            self.locations = self.getFavoritesLocations()
            self.delegate?.loadFavoritesLocations(locations: self.locations)
        }
    }
}
