//
//  XCTestCase+Extension.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import XCTest

extension XCTestCase {
    func getParseObject<T: Decodable>(from jsonResourceName: String) -> T? {
        var object: T?
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: jsonResourceName, ofType: "json") else {
            XCTFail("Unable to load resource \(jsonResourceName)")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            object = try decoder.decode(T.self, from: data)
        } catch let error {
            XCTFail("\(error) setup of \(String(describing: self))")
        }
        return object
    }
}
