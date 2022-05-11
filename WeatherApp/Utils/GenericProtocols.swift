//
//  GenericProtocols.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

protocol LoadinSpinner: AnyObject {
    func showLoading()
    func hideLoading()
}

protocol DataViewControllerProtocol: AnyObject {
    func updateData(with error:Error?)
    func showErrorView(with error:Error?)
}
