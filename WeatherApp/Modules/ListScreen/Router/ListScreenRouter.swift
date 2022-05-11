//
//  ListScreenRouter.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation

protocol ListScreenRouterProtocol : AnyObject {
    var viewController: ListScreenViewController? {get set}
    func routeToDetail(location: Location)
}

class ListScreenRouter: ListScreenRouterProtocol {
    weak var viewController: ListScreenViewController?

    func routeToDetail(location: Location) {
        guard let viewController = viewController else { return }
        viewController.performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
}
