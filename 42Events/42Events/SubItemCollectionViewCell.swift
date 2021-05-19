//
//  SubItemCollectionViewCell.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import UIKit

class SubItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCornersWith(radius: 15)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
    }
    func setData(title: String) {
        titleLbl.text = title
    }
    
}
