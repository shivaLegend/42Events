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
    
    private var listSubItem: [String] = []
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
    func setData(data: Item) {
        listSubItem.removeAll()
        titleLbl.text = data.title
        subTitleLbl.text = data.subTitle
        imgView.sd_setImage(with: URL(string: data.urlImage), placeholderImage: UIImage(named: "placeholder.png"))
        for i in data.tags {
            if i != "" {
                listSubItem.append(i)
            }
        }
        collectionView.reloadData()
    }
}
extension ItemCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listSubItem.isEmpty {return 4}
        return listSubItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubItemCollectionViewCell", for: indexPath) as! SubItemCollectionViewCell
        if listSubItem.isEmpty {return cell}
        cell.setData(title: listSubItem[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        if listSubItem.isEmpty {return CGSize(width: 0, height: 28)}
        label.text = listSubItem[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 10, height: 28)
    }
}
