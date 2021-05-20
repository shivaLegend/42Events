//
//  ViewController.swift
//  42Events
//
//  Created by Tai Nguyen on 17/05/2021.
//

import UIKit
import FSPagerView
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pageControlView: FSPageControl!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var startingSoonCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var newReleaseCollectionView: UICollectionView!
    @IBOutlet weak var freeCollectionView: UICollectionView!
    @IBOutlet weak var pastRacesCollectionView: UICollectionView!
    
    private var listImagePagerView = [UIImage(named: "img1.jpeg"),
                             UIImage(named: "img2.jpeg"),
                             UIImage(named: "img3.jpeg"),
                             UIImage(named: "img4.jpeg")]
    private let listEvent = ["Running", "Cycling", "Walking"]
    private let listEventColor = [UIColor(red: 0/255, green: 192/255, blue: 174/255, alpha: 1.0),
                                  UIColor(red: 20/255, green: 188/255, blue: 239/255, alpha: 1.0),
                                  UIColor(red: 249/255, green: 115/255, blue: 79/255, alpha: 1.0)]
    private var data: DataItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        callAPIRaceEvents()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.menuWidth = UIScreen.main.bounds.width*3/4
    }
    
    //MARK: - UI functions
    func initUI() {
        title = "Home"
        initPagerView()
        initCollectionView()
        initPageControl()
        initSideMenu()
        
    }
    func initSideMenu() {
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        
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
        pageControlView.numberOfPages = listImagePagerView.count
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
        
        popularCollectionView.backgroundColor = .clear
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        newReleaseCollectionView.backgroundColor = .clear
        newReleaseCollectionView.delegate = self
        newReleaseCollectionView.dataSource = self
        newReleaseCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        freeCollectionView.backgroundColor = .clear
        freeCollectionView.delegate = self
        freeCollectionView.dataSource = self
        freeCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        pastRacesCollectionView.backgroundColor = .clear
        pastRacesCollectionView.delegate = self
        pastRacesCollectionView.dataSource = self
        pastRacesCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
    }
    //MARK: - Handler functions
    
    //MARK: - API functions
    func callAPIRaceEvents() {
        Reachability.checkNetwork(vc: self)
        provider.request(.raceEvents) { (result) in
            if let json = DataManager.shared.isSuccessData(result: result, vc: self) {
                self.data = DataItems(json: json)
                self.startingSoonCollectionView.reloadData()
                self.popularCollectionView.reloadData()
                self.newReleaseCollectionView.reloadData()
                self.freeCollectionView.reloadData()
                self.pastRacesCollectionView.reloadData()
               
            }
        }
    }
}

//MARK: -UICollectionViewDataSource, UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case eventsCollectionView:
            return listEvent.count
        case startingSoonCollectionView:
            return data?.startingSoon.count ?? 3
        case popularCollectionView:
            return data?.popular.count ?? 3
        case newReleaseCollectionView:
            return data?.newRelease.count ?? 3
        case freeCollectionView:
            return data?.free.count ?? 3
        case pastRacesCollectionView:
            return data?.past.count ?? 3
        default:
            break
        }
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
            guard let temp = data?.startingSoon[indexPath.row] else {return cell}
            cell.setData(data: temp)
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            guard let temp = data?.popular[indexPath.row] else {return cell}
            cell.setData(data: temp)
            return cell
        case newReleaseCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            guard let temp = data?.newRelease[indexPath.row] else {return cell}
            cell.setData(data: temp)
            return cell
        case freeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            guard let temp = data?.free[indexPath.row] else {return cell}
            cell.setData(data: temp)
            return cell
        case pastRacesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            guard let temp = data?.past[indexPath.row] else {return cell}
            cell.setData(data: temp)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
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
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case eventsCollectionView:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EventViewController") as! EventViewController
            vc.title = listEvent[indexPath.row]
            switch indexPath.row {
            case 0:
                vc.typeEvent = .Running
            case 1:
                vc.typeEvent = .Cycling
            case 2:
                vc.typeEvent = .Walking
            default:
                break
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

//MARK: - FSPagerViewDelegate, FSPagerViewDataSource
extension HomeViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listImagePagerView.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = listImagePagerView[index]
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
