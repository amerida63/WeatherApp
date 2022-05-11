//
//  DetailLocationTableViewCell.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import UIKit
import SDWebImage

class DetailLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var bgView: UIView!

    static var identifier: String {
        return String(describing: Self.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with weather: ConsolidatedWeather)
    {
        bgView.layer.cornerRadius = 10
        dayNameLabel.text = weather.applicableDate?.getDateDay()
        let minTemp = String.localizedStringWithFormat("%@ %.2f %@", "min".localized(), weather.minTemp ?? 0.0, "°C")
        let maxTemp = String.localizedStringWithFormat("%@ %.2f %@", "max".localized(), weather.minTemp ?? 0.0, "°C")
        temperatureLabel.text = "\(minTemp) - \(maxTemp)"
        
        guard let url = URL(string: String(format: Constants.baseImageUrl, weather.weatherStateAbbr ?? "")) else {
            return
        }
        imgView.sd_setImage(with: url)
    }
}
