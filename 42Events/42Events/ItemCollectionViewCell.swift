//
//  ItemCollectionViewCell.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    
    var listSubItem = ["Running","joinded","Single submission","Multiple submission"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCornersWith(radius: 10)
        initCollectionView()
        
    }
    func initCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SubItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubItemCollectionViewCell")
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        self.layoutIfNeeded()
        
        let temp = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = temp
    }
    func setData(image: String, title: String, subTitle: String) {
        titleLbl.text = title
        subTitleLbl.text = subTitle
        imgView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
}
extension ItemCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSubItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubItemCollectionViewCell", for: indexPath) as! SubItemCollectionViewCell
        cell.setData(title: listSubItem[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = listSubItem[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 10, height: 28)
    }
}
