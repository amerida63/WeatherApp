//
//  DetailListInteractor.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import Foundation

protocol DetailListInteractorProtocol: AnyObject {
    func getDetailLocation(with id: Int, completion: @escaping(_ response: Result<DetailLocation, Error>) -> ())
    func checkIfIsFavorite(location: Location, completion: @escaping(_ exist: Bool) -> ())
    func saveLocation(location: Location)
    func deleteLocation(location: Location)
}

final class DetailListInteractor: DetailListInteractorProtocol {
    let service = DetailListService()
    func getDetailLocation(with id: Int, completion: @escaping(_ response: Result<DetailLocation, Error>) -> ()) {
        service.getDetailLocation(with: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                //TODO: show an error
                break
            }
        }
    }
    
    func checkIfIsFavorite(location: Location, completion: @escaping(_ exist: Bool) -> ()) {
        DispatchQueue.main.async {
            let modelExist = APICoreDataService.shared.checkIfExist(location)
            completion(modelExist)
        }
    }
    
    func saveLocation(location: Location){
        DispatchQueue.main.async {
            APICoreDataService.shared.create([location])
        }
    }
    
    func deleteLocation(location: Location) {
        DispatchQueue.main.async {
            APICoreDataService.shared.deleteObject(location)
        }
    }
}
