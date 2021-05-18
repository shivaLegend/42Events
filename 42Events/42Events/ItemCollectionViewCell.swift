//
//  ItemCollectionViewCell.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import UIKit
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var listSubItem = ["Running","joinded","Single submission","Multiple submission"]
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCornersWith(radius: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SubItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubItemCollectionViewCell")
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionViewHeight.constant = height
        self.layoutIfNeeded()
        
        let temp = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = temp
    }

}
extension ItemCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
