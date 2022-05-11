//
//  FavoriteTableViewCell.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LocationNameLabel: UILabel!
    @IBOutlet weak var LocationTypeLabel: UILabel!

    static var identifier: String {
        return String(describing: Self.self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with location:Location)
    {
        LocationNameLabel.text = location.title
        LocationTypeLabel.text = location.locationType
    }

}
