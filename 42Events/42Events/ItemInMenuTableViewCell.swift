//
//  ItemInMenuTableViewCell.swift
//  42Events
//
//  Created by Tai Nguyen on 20/05/2021.
//

import UIKit

class ItemInMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(text: String, img: UIImage) {
        iconImgView.image = img
        titleLbl.text = text
    }
    
}
