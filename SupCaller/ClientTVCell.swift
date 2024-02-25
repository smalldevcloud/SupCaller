//
//  ClientTVCell.swift
//  SupCaller
//
//  Created by 8 on 12.12.23.
//

import UIKit

class ClientTVCell: UITableViewCell {
    static let identifier = "clientsTVCell"
    var callButtonHandler: (() -> Void)?

    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientNumber: UILabel!
    @IBOutlet weak var callButton: UIButton!

    @IBAction func callButtonPressed(_ sender: Any) {
        //        вызов замыкания по нажатию кнопки
                callButtonHandler?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .backgroundCellColor
        callButton.backgroundColor = .darkGray
        callButton.layer.cornerRadius = callButton.frame.width / 2
        callButton.layer.cornerCurve = .circular
    }
}
