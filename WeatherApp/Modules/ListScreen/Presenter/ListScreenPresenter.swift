//
//  ListScreenPresenter.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation

protocol ListScreenPresenterProtocol: AnyObject {
    var delegate: ListScreenViewControllerProtocol? { get set }
    var interactor: ListScreenInteractorProtocol { get }
    var router: ListScreenRouterProtocol { get set }
    var locations: [Location] { get set }
    var saveLocations: [Location] { get set }
    var selectedLocation: Location? { get set }
    func viewDidLoad()
    func getFavorites()
    func searchLocation(with text: String)
    func openLocation(from index: Int)
    func goTodetail(with location: Location)
}

protocol PresenterToInteractorProtocol: AnyObject {
    func loadFavoritesLocations(locations: [Location])
}

final class ListScreenPresenter: ListScreenPresenterProtocol {    
    weak var delegate: ListScreenViewControllerProtocol?
    var interactor: ListScreenInteractorProtocol = ListScreenInteractor()
    var router: ListScreenRouterProtocol = ListScreenRouter()
    var locations: [Location] = []
    var saveLocations: [Location] = []
    var selectedLocation: Location? = nil
    
    func viewDidLoad() {
        interactor.delegate = self
        getFavorites()
    }
    
    func getFavorites() {
        interactor.fillLocationsInCache()
    }
    
    func searchLocation(with text: String) {
        interactor.getLocations(with: text) { [weak self] result in
            guard let self = self else { return }
            //self.delegate?.hideLoading()
            switch result {
            case .success(let locations):
                self.locations = locations
                self.delegate?.updateData(with: nil)
            case .failure(let error):
                self.delegate?.updateData(with: error)
            }
        }
    }
    
    func openLocation(from index: Int) {
        goTodetail(with: locations[index])
    }
    
    func goTodetail(with location: Location) {
        selectedLocation = location
        router.routeToDetail(location: location)
    }
}

extension ListScreenPresenter: PresenterToInteractorProtocol {
    func loadFavoritesLocations(locations: [Location]) {
        self.saveLocations = locations
        self.delegate?.updateFavoritesLocation()
    }
}
