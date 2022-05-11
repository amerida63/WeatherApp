//
//  ListScreenService.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Alamofire

final class ListScreenService: BaseServices {
    var request: DataRequest? = nil

    func searchLocations(with text: String, completion: @escaping(_ response: Result<[Location],Error>) -> Void) {
        request?.cancel()
        request = nil
        request = BaseServices.requestGET(url: String(format: Constants.Url.search, text), responseType: [Location].self) { (result, error) in
            guard error == nil, let result = result as? [Location] else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result))
        }
    }
}
