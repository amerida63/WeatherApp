//
//  ListScreenPresenterMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class ListScreenPresenterMock: ListScreenPresenterProtocol {
    var delegate: ListScreenViewControllerProtocol? = ListScreenMock()
    var interactor: ListScreenInteractorProtocol = ListScreenInteractorMock()
    var router: ListScreenRouterProtocol = ListScreenRouterMock()
    var locations: [Location] = []
    var saveLocations: [Location] = []
    var selectedLocation: Location? = nil
    
    func viewDidLoad() {}
    
    func getFavorites() {
        interactor.fillLocationsInCache()
    }
    
    func searchLocation(with text: String) {
        interactor.getLocations(with: "", completion: { result in })
    }
    
    func openLocation(from index: Int) {
    }
    
    func goTodetail(with location: Location) {
        router.routeToDetail(location: location)
    }

}
