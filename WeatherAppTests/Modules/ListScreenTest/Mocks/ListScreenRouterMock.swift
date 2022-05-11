//
//  ListScreenRouterMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class ListScreenRouterMock: ListScreenRouterProtocol {
    var viewController: ListScreenViewController?
    var didToDetail: ((_ location: Location)->())?

    func routeToDetail(location: Location) {
        if let didToDetail = didToDetail {
            didToDetail(location)
        }
    }
}
