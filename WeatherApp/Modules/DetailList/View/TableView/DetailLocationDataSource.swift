//
//  DetailLocationDataSource.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import UIKit

class DetailLocationDataSource: NSObject {
    var tableView: UITableView!
    var listData: [ConsolidatedWeather] = []
    
    func setupView(_ tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setDataOfView(_ data: [ConsolidatedWeather]) {
        self.listData = data
        self.listData.removeFirst()
        tableView.reloadData()
    }
}

extension DetailLocationDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailLocationTableViewCell.identifier, for: indexPath) as! DetailLocationTableViewCell
        cell.configureCell(with: listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
