//
//  EventCollectionViewCell.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCornersWith(radius: 10)
        
    }
    func setData(name: String, color: UIColor) {
        nameLbl.text = name
        backgroundColor = color
    }
    
}
