//
//  ListScreenTest.swift
//  WeatherAppTests
//
//  Created by Anthony merida on 5/11/22.
//

import XCTest
@testable import WeatherApp

class ListScreenTest: XCTestCase {
    lazy var locationsResponse: [Location]? = getParseObject(from: "LocationResponse")
    var presenter: ListScreenPresenterMock?
    var interactor = ListScreenInteractorMock()
    var router = ListScreenRouterMock()
    let view = ListScreenMock()
    
    override func setUp() {
        super.setUp()
        presenter = ListScreenPresenterMock()
        presenter?.locations = locationsResponse ?? []
        presenter?.router = router
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
    
    func testCallSearch() {
        let promise = expectation(description: "Success")
        interactor.didList = {
            promise.fulfill()
        }
        presenter?.searchLocation(with: "")
        wait(for: [promise], timeout: 30)
    }
    
    func testCallFavorites() {
        let promise = expectation(description: "Success")
        interactor.didCache = {
            promise.fulfill()
        }
        presenter?.getFavorites()
        wait(for: [promise], timeout: 30)
    }
    
    func testgoToDetail() {
        guard let location = locationsResponse?[0] else {
            XCTFail("locationsResponse can't be nil")
            return
        }
        let promise = expectation(description: "Success")
        router.didToDetail = { result in
            XCTAssertEqual(location.woeid, result.woeid)
            promise.fulfill()
        }
        presenter?.goTodetail(with: location)
        wait(for: [promise], timeout: 30)
    }

}
