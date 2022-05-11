//
//  ResultTableViewController.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import UIKit

protocol ResultTableProtocol: AnyObject {
    func didSelect(_ index: Int)
}

class ResultTableViewController: UITableViewController {
    
    weak var delegate: ResultTableProtocol?
    var search = [Location]()
    var isEmptySearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refreshTableView(with locations:[Location]) {
        self.isEmptySearch = false
        self.search = locations
        self.tableView.reloadData()
    }
    
    func updateEmptyView() {
        self.isEmptySearch = true
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isEmptySearch ? 1 : search.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        let titleCell = isEmptySearch ? "No se encontraron resultados".localized() : search[indexPath.row].title
        cell.configureCell(with: titleCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isEmptySearch else {
            return
        }
        self.delegate?.didSelect(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
