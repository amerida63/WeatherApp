//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/10/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttons: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for button in buttons {
            alert.addAction(button)
        }
        present(alert, animated: true, completion: nil)
    }
}
