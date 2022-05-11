//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/8/22.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    func testSearchList() {
        getListService()
    }
    
    func testGetDetail() {
        getDetailService()
    }
    
    func getListService() {
        let service = ListScreenService()
        let promise = expectation(description: "Success")
        service.searchLocations(with: "sa"){ (result) in
            switch result {
            case .success(_):
                promise.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [promise], timeout: 30)
    }
    
    func getDetailService() {
        let service = DetailListService()
        let promise = expectation(description: "Success")
        service.getDetailLocation(with: 9807) { (result) in
            switch result {
            case .success(_):
                promise.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [promise], timeout: 30)
    }
}
