//
//  ListScreenDataSource.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import UIKit

protocol ListScreenDataSourceProtocol: class {
    func removeFavorite(_ index: Int)
    func openFavorite(_ location: Location)
}

class ListScreenDataSource: NSObject {
    
    weak var delegate: ListScreenDataSourceProtocol?
    var tableView: UITableView!
    var listData: [Location] = []
    
    func setupView(_ tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.tableFooterView = UIView()  // it's just 1 line, awesome!
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setDataOfView(_ data: [Location]) {
        self.listData = data
        tableView.reloadData()
    }
    
    func setContentOffSetToZero() {
        self.tableView.setContentOffset(.zero, animated: true)
    }
}

extension ListScreenDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.configureCell(with: listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.openFavorite(listData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) {[weak self] (_, _, completionHandler)  in
                guard let self = self else { return }
                self.delegate?.removeFavorite(indexPath.row)
                self.listData.remove(at: indexPath.row)
                self.tableView.reloadData()
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
}
