//
//  BaseServices.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation
import Alamofire

class BaseServices: NSObject {
    
    typealias CompletionBlock = (Decodable?, Error?) -> ()
    
    //MARK: Static functions
    @discardableResult static func requestGET<T: Decodable>(url: String, responseType: T.Type, completion: @escaping CompletionBlock) -> DataRequest? {
        return request(url: url, responseType: responseType, completion: completion)
    }
}

//MARK:- Private functions
private extension BaseServices {
    @discardableResult static func request<T: Decodable>(url: String, responseType: T.Type, completion: @escaping CompletionBlock) -> DataRequest? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let urlString = buildUrl(with: url)
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return nil
        }
        
        let afRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        
        return afRequest
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let response = try decoder.decode(responseType.self, from: data)
                        completion(response, nil)
                    } catch {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    static func buildUrl(with path: String) -> String {
        return Constants.Url.base + path
    }
}
