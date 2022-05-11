//
//  ListScreenViewController.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import UIKit

protocol ListScreenViewControllerProtocol: DataViewControllerProtocol {
    func updateFavoritesLocation()
}

class ListScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var resultVC: ResultTableViewController = ({
        // Display search results in a separate view controller
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let resultTableViewController = storyBoard.instantiateViewController(withIdentifier: "resultController") as! ResultTableViewController
        resultTableViewController.delegate = self
        return resultTableViewController
    })()
    
    lazy var listSearchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: resultVC)
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.searchBarStyle = .minimal
        controller.searchResultsUpdater = self
        controller.searchBar.sizeToFit()
        return controller
    })()
    
    var presenter: ListScreenPresenterProtocol = ListScreenPresenter()
    private let tableViewDataSource = ListScreenDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavorites()
    }
    
    //MARK: Functions
    private func setupView() {
        presenter.delegate = self
        presenter.router.viewController = self
        presenter.viewDidLoad()
        setupTableView()
        configureNavigation()
    }
    
    private func setupTableView() {
        tableViewDataSource.delegate = self
        tableViewDataSource.setupView(tableView)
    }
    
    private func configureNavigation() {
        // Configure navigation item to display search controller.
        navigationItem.searchController = listSearchController
        navigationItem.title = "listScren.title.navigation".localized()
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func openLocation(_ index: Int) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = presenter.selectedLocation, let detailVC = segue.destination as? DetailListViewController else {
            return
        }
        detailVC.presenter.location = location
    }
}

extension ListScreenViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        if searchController.searchBar.text?.utf8.count != 0 {
            presenter.searchLocation(with: searchController.searchBar.text ?? "")
        }
    }
}

extension ListScreenViewController: ListScreenViewControllerProtocol {
    func updateData(with error: Error?) {
        guard error == nil else {
            showErrorView(with: error)
            return
        }
        if presenter.locations.count == 0 && !(listSearchController.searchBar.text?.isEmpty ?? true) {
            resultVC.updateEmptyView()
            return
        }
        resultVC.refreshTableView(with: presenter.locations)
    }
    
    func showErrorView(with error: Error?) {
        let action = UIAlertAction(title: "listScren.alert.generic.action.title.button".localized(), style: .default) { [weak self](_) in
            self?.listSearchController.searchBar.text = nil
            self?.listSearchController.dismiss(animated: false)
        }
        showAlert(title: "listScren.alert.generic.title.error".localized(), message: error?.localizedDescription ?? "listScren.alert.defaul.message.error".localized(),buttons: [action])
    }
    
    func updateFavoritesLocation() {
        tableViewDataSource.setDataOfView(presenter.saveLocations)
    }
}

extension ListScreenViewController : ListScreenDataSourceProtocol {
    func removeFavorite(_ index: Int) {
    }
    
    func openFavorite(_ location: Location) {
        presenter.goTodetail(with: location)
    }
}

extension ListScreenViewController: ResultTableProtocol {
    func didSelect(_ index: Int) {
        listSearchController.searchBar.text = ""
        listSearchController.dismiss(animated: false)
        presenter.openLocation(from: index)
    }
}
