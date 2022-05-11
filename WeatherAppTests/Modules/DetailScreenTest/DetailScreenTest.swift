//
//  DetailScreenTest.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import XCTest
@testable import WeatherApp

class DetailScreenTest: XCTestCase {
    lazy var detailResponse: DetailLocation? = getParseObject(from: "DetailResponse")
    lazy var locationsResponse: [Location]? = getParseObject(from: "LocationResponse")
    var presenter: DetailScreenPresenterMock?
    var interactor = DetailScreenInteractorMock()
    let view = DetailScreenMock()
    var searchLocation : Location?
    
    override func setUp() {
        super.setUp()
        
        guard let location = locationsResponse?[0] else {
            XCTFail("")
            return
        }
        searchLocation = location
        presenter = DetailScreenPresenterMock()
        presenter?.location = location
        presenter?.interactor = interactor
        presenter?.delegate = view
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testCallUpdateData() {
        presenter?.delegate?.updateData(with: nil)
        XCTAssertEqual(view.numberOfTimeUpdateDataCalled, 1)
    }
    
    func testCallUpdateDataWithError() {
        let error = NSError(domain:"", code:2, userInfo:[NSLocalizedDescriptionKey: "TestCase Error"])
        presenter?.delegate?.updateData(with: error)
        XCTAssertEqual(view.error?.localizedDescription, error.localizedDescription)
    }
    
    func testCallShowError() {
        presenter?.delegate?.showErrorView(with: nil)
        XCTAssertEqual(view.numberOfShowErrorCalled, 1)
    }
    
    func testCallGetDetail() {
        let promise = expectation(description: "Success")
        interactor.didDetail = {
            promise.fulfill()
        }
        presenter?.getDetailLocation(with: searchLocation?.woeid ?? 0)
        wait(for: [promise], timeout: 30)
    }
    
    func testCallFavorite() {
        let promise = expectation(description: "Success")
        interactor.didFavorite = { [weak self] result in
            XCTAssertEqual(result.woeid, self?.searchLocation?.woeid ?? 99)
            promise.fulfill()
        }
        presenter?.viewDidLoad()
        wait(for: [promise], timeout: 30)
    }
    
    func testFavoritesCall() {
        let promiseSave = expectation(description: "Success")
        let promiseDelete = expectation(description: "Success")

        presenter?.isFavorite = true
        interactor.didDelete = { [weak self] result in
            XCTAssertEqual(result.woeid, self?.searchLocation?.woeid ?? 99)
            promiseDelete.fulfill()
        }
        interactor.didSave = { [weak self] result in
            XCTAssertEqual(result.woeid, self?.searchLocation?.woeid ?? 99)
            promiseSave.fulfill()
        }
        presenter?.updateFavoriteStateButton()
        presenter?.isFavorite = false
        presenter?.updateFavoriteStateButton()
        wait(for: [promiseSave, promiseDelete], timeout: 30)
    }
    
    func testRenderData() {
        presenter?.renderData(with: detailResponse)
        XCTAssertNotNil(presenter?.detail)
        XCTAssertEqual(view.numberOfTimeUpdateDataCalled, 1)
    }

}
