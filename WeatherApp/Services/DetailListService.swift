//
//  DetailListService.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

final class DetailListService: BaseServices {
    
    func getDetailLocation(with id: Int, completion: @escaping(_ response: Result<DetailLocation,Error>) -> Void) {
        BaseServices.requestGET(url: String(format: Constants.Url.detail, "\(id)"), responseType: DetailLocation.self) { (result, error) in
            guard error == nil, let result = result as? DetailLocation else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result))
        }
    }
}
