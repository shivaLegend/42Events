//
//  ViewController.swift
//  42Events
//
//  Created by Tai Nguyen on 17/05/2021.
//

import UIKit
import FSPagerView
class HomeViewController: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pageControlView: FSPageControl!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var startingSoonCollectionView: UICollectionView!
    
    private let listImage = [UIImage(named: "img1.jpeg"),
                             UIImage(named: "img2.jpeg"),
                             UIImage(named: "img3.jpeg"),
                             UIImage(named: "img4.jpeg")]
    private let listEvent = ["Running", "Cycling", "Walking"]
    private let listEventColor = [UIColor(red: 0/255, green: 192/255, blue: 174/255, alpha: 1.0),
                                  UIColor(red: 20/255, green: 188/255, blue: 239/255, alpha: 1.0),
                                  UIColor(red: 249/255, green: 115/255, blue: 79/255, alpha: 1.0)]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        callAPIRaceEvents()
    }
    
    
    //MARK: - UI functions
    func initUI() {
        title = "Home"
        initPagerView()
        initCollectionView()
        initPageControl()
    }
    func initPagerView() {
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 10
        pagerView.itemSize = CGSize(width: pagerView.bounds.width - 70, height: pagerView.bounds.height)
        pagerView.automaticSlidingInterval = 2
    }
    func initPageControl() {
        pageControlView.numberOfPages = listImage.count
        pageControlView.contentHorizontalAlignment = .center
        pageControlView.backgroundColor = .clear
        pageControlView.setFillColor(.red, for: .selected)
    }
    func initCollectionView() {
        eventsCollectionView.backgroundColor = .clear
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell")
        startingSoonCollectionView.backgroundColor = .clear
        startingSoonCollectionView.delegate = self
        startingSoonCollectionView.dataSource = self
        startingSoonCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
    }
    //MARK: - Handler functions
    
    //MARK: - API functions
    func callAPIRaceEvents() {
        provider.request(.raceEvents) { (result) in
            if let _  = DataManager.shared.isSuccessData(result: result, vc: self) {
                
            }
        }
    }
}

//MARK: -UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listEventColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case eventsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
            cell.setData(name: listEvent[indexPath.row], color: listEventColor[indexPath.row])
            return cell
        case startingSoonCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
            cell.setData(name: listEvent[indexPath.row], color: listEventColor[indexPath.row])
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case eventsCollectionView:
            return CGSize(width: (collectionView.bounds.width - 20)/3, height: collectionView.bounds.height)
        case startingSoonCollectionView:
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height)
        default:
            return CGSize(width: (collectionView.bounds.width - 20)/3, height: collectionView.bounds.height)
        }
    }
}

//MARK: - FSPagerViewDelegate, FSPagerViewDataSource
extension HomeViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listImage.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = listImage[index]
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControlView.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControlView.currentPage = pagerView.currentIndex
    }
}
