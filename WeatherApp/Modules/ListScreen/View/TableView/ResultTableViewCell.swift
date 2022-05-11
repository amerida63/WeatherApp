//
//  ResultTableViewCell.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!

    static var identifier: String {
        return String(describing: Self.self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with countryName:String)
    {
        countryNameLabel.text = countryName
    }
}
