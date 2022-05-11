//
//  DetailScreenPresenterMock.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import Foundation
@testable import WeatherApp

final class DetailScreenPresenterMock: DetailListPresenterProtocol {
    var delegate: DetailListProtocol? = DetailScreenMock()
    var interactor: DetailListInteractorProtocol = DetailScreenInteractorMock()
    var location: Location? = nil
    var detail: RenderLocation? = nil
    var isFavorite: Bool = false
    
    func viewDidLoad() {
        guard let location = location else {
            return
        }
        interactor.checkIfIsFavorite(location: location, completion: {_ in})
    }
    
    func getDetailLocation(with woeid: Int) {
        interactor.getDetailLocation(with: woeid, completion: {_ in})
    }
    
    func updateFavoriteStateButton() {
        guard let location = location else {
            return
        }
        if isFavorite {
            interactor.deleteLocation(location: location)
            return
        }
        interactor.saveLocation(location: location)
    }
    
    func renderData(with detail: DetailLocation?) {
        guard let detailLocation = detail else {
            return
        }
        self.detail = RenderLocation(title: detailLocation.title, consolidatedWeather: detailLocation.consolidatedWeather?.first, otherDates: detailLocation.consolidatedWeather)
        delegate?.updateData(with: nil)
    }
}
