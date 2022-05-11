//
//  DetailListViewController.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage

protocol DetailListProtocol: DataViewControllerProtocol, LoadinSpinner {
    func updateFavoriteButton()
}

class DetailListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var temperatureTitleLabel: UILabel!
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var humidityTitleLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var windTitleLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var favoriteButton: UIButton!
    var presenter: DetailListPresenterProtocol = DetailListPresenter()
    private let tableViewDataSource = DetailLocationDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showScroll(false)
        showLoading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            scrollView.isScrollEnabled = true
        } else {
            scrollView.isScrollEnabled = false
        }
    }

    private func setupView() {
        scrollView.isScrollEnabled = UIDevice.current.orientation.isLandscape
        titleLabel.text = "detailList.title.label".localized()
        humidityTitleLabel.text = "detailList.humedad.title.label".localized()
        windTitleLabel.text = "detailList.viento.title.label".localized()
        showLoading()
        presenter.delegate = self
        presenter.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewDataSource.setupView(tableView)
    }
    
    private func renderData() {
        guard  let detailLocation = presenter.detail else {
            return
        }
        stateLabel.text = detailLocation.title
        temperatureTitleLabel.text = detailLocation.consolidatedWeather?.weatherStateName
        temperatureValueLabel.text = String.localizedStringWithFormat("%.2f %@", detailLocation.consolidatedWeather?.theTemp ?? 0.0, "°C")
        humidityValueLabel.text = "\(detailLocation.consolidatedWeather?.humidity ?? 0)"
        windValueLabel.text = String.localizedStringWithFormat("%.0f %@", detailLocation.consolidatedWeather?.windSpeed ?? 0.0, "km/h")
        tableViewDataSource.setDataOfView(detailLocation.otherDates ?? [])
        guard let url = URL(string: String(format: Constants.baseImageUrl, detailLocation.consolidatedWeather?.weatherStateAbbr ?? "")) else {
            return
        }
        imageWeather.sd_setImage(with: url)
    }
    
    private func showScroll(_ value: Bool) {
        scrollView.isHidden = !value
    }
    
    @IBAction func updateFavoriteButton(_ sender: UIButton) {
        presenter.updateFavoriteStateButton()
        self.updateFavoriteButton()
    }
}

extension DetailListViewController: DetailListProtocol {
    func updateData(with error: Error?) {
        showErrorView(with: error)
        return
        guard error == nil else {
            showErrorView(with: error)
            return
        }
        hideLoading()
        renderData()
        showScroll(true)
    }
    
    func showErrorView(with error: Error?) {
        let action = UIAlertAction(title: "listScren.alert.generic.action.title.button".localized(), style: .default) { [weak self](_) in
            self?.dismiss(animated: true)
        }
        showAlert(title: "listScren.alert.generic.title.error".localized(), message: error?.localizedDescription ?? "detailList.alert.message.error".localized(),buttons: [action])
    }
    
    func showLoading() {
        loadingView.startAnimating()
    }
    
    func hideLoading() {
        loadingView.stopAnimating()
    }
    
    func updateFavoriteButton() {
        DispatchQueue.main.async {
            self.favoriteButton.setTitle(self.presenter.isFavorite ? "detailList.remove.favorite.button.title".localized() : "detailList.add.favorite.button.title".localized(), for: .normal)
            let image = self.presenter.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            image?.withTintColor(self.presenter.isFavorite ? .red : .black)
            self.favoriteButton.setImage(image, for: .normal)
        }
    }
    
}
