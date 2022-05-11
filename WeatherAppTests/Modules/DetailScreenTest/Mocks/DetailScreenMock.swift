//
//  DetailScreenMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class DetailScreenMock: DetailListProtocol {
    
    var numberOfTimeUpdateDataCalled = 0
    var numberOfShowErrorCalled = 0
    var numberOfFavoriteCalled = 0
    var error : Error?
    
    func updateFavoriteButton() {
        numberOfFavoriteCalled += 1
    }
    
    func updateData(with error: Error?) {
        numberOfTimeUpdateDataCalled += 1
        self.error = error
    }
    
    func showErrorView(with error: Error?) {
        numberOfShowErrorCalled += 1
    }
    
    func showLoading() {}
    
    func hideLoading() {}

}
