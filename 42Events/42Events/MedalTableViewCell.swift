//
//  MedalTableViewCell.swift
//  42Events
//
//  Created by Tai Nguyen on 21/05/2021.
//

import UIKit

class MedalTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView! {
        didSet {
            imgView.roundCornersWith(radius: 4)
        }
    }
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var tagLbl: UILabel!
    private var listSubItem: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCornersWith(radius: 10)
        tagLbl.text = ""
    }
    
    func setData(data: Item) {
        listSubItem.removeAll()
        titleLbl.text = data.title
        subTitleLbl.text = data.subTitle
        imgView.sd_setImage(with: URL(string: data.medalImage), placeholderImage: UIImage(named: "placeholder.png"))
        for tag in data.tags {
            if tag != "" {
                self.tagLbl.text?.append(tag)
            }
            if tag != data.tags.last  {
                self.tagLbl.text?.append(" ° ")
            }
        }
        
    }
    
}

