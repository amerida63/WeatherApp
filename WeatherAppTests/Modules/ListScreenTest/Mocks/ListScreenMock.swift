//
//  ListScreenMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class ListScreenMock: ListScreenViewControllerProtocol {
    var numberOfTimeUpdateDataCalled = 0
    var numberOfShowErrorCalled = 0
    var numberOfFavoriteCalled = 0
    var error : Error?

    func showErrorView() {
        numberOfShowErrorCalled += 1
    }
    
    func updateFavoritesLocation() {
        numberOfFavoriteCalled += 1
    }
    
    func updateData(with error: Error?) {
        self.error = error
        numberOfTimeUpdateDataCalled += 1
    }
    
    func showErrorView(with error: Error?) {
        self.error = error
        numberOfShowErrorCalled += 1
    }
}
