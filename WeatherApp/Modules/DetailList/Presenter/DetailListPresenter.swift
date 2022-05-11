//
//  DetailListPresenter.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import Foundation

protocol DetailListPresenterProtocol: AnyObject {
    var delegate: DetailListProtocol? { get set }
    var interactor: DetailListInteractorProtocol { get }
    var location: Location? { get set }
    var detail: RenderLocation? { get set }
    var isFavorite: Bool { get set }
    func viewDidLoad()
    func getDetailLocation(with woeid: Int)
    func updateFavoriteStateButton()
    func renderData(with detail: DetailLocation?)
}

final class DetailListPresenter: DetailListPresenterProtocol {
    weak var delegate: DetailListProtocol?
    var interactor: DetailListInteractorProtocol = DetailListInteractor()
    var location: Location?
    var detail: RenderLocation?
    var isFavorite: Bool = false
    
    func viewDidLoad() {
        guard let location = location else {
            return
        }
        checkButton(location: location)
        getDetailLocation(with: location.woeid)
    }
    
    func getDetailLocation(with woeid: Int) {
        interactor.getDetailLocation(with: woeid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let detail):
                self.renderData(with: detail)
            case .failure(let error):
                self.delegate?.updateData(with: error)
            }
        }
    }
    
    func updateFavoriteStateButton() {
        isFavorite = !isFavorite
        
        guard let location = location else {
            return
        }
        if isFavorite {
            interactor.saveLocation(location: location)
            return
        }
        interactor.deleteLocation(location: location)
    }
    
    func checkButton(location: Location) {
        interactor.checkIfIsFavorite(location: location) { (exist) in
            self.isFavorite = exist
            self.delegate?.updateFavoriteButton()
        }
    }
    
    func renderData(with detail: DetailLocation?) {
        guard let detailLocation = detail else {
            return
        }
        self.detail = RenderLocation(title: detailLocation.title, consolidatedWeather: detailLocation.consolidatedWeather?.first, otherDates: detailLocation.consolidatedWeather)
        self.delegate?.updateData(with: nil)
    }
}
