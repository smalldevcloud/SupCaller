//
//  Extensions.swift
//  SupCaller
//
//  Created by 8 on 18.02.24.
//

import Foundation
import UIKit

extension UIViewController {
//    нужно для того, чтобы по тапу по свободному пространству экрана клавиатура пряталась
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    static let backgroundViewColor = UIColor(named: "backgroundViewColor")
    static let backgroundCellColor = UIColor(named: "backgroundCellColor")

}
