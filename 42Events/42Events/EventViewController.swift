//
//  EventViewController.swift
//  42Events
//
//  Created by Tai Nguyen on 20/05/2021.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalEventsLbl: UILabel!
    private let heightOfCell: CGFloat = 300
    private var data: DetailEvent?
    var typeEvent: TypeEvent = .Cycling
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        callAPIRaceEvents()
    }
    
    
    //MARK: - UI functions
    func initUI() {
        initCollectionView()
    }
    func initCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
    }
    //MARK: - Handler functions
    
    //MARK: - API functions
    func callAPIRaceEvents() {
        var type = ""
        switch typeEvent {
        case .Cycling:
            type = "cycling"
        case .Walking:
            type = "walking"
        default:
            type = "running"
        }
        Reachability.checkNetwork(vc: self)
        provider.request(.getDetailEvent(skipCount: "0", limit: "10", type: type)) { (result) in
            if let json = DataManager.shared.isSuccessData(result: result, vc: self) {
                self.data = DetailEvent(json: json)
                self.totalEventsLbl.text = String(self.data?.total ?? 0) + " \(type) events"
                self.collectionView.reloadData()
            }
        }
    }
}
//MARK: -UICollectionViewDataSource, UICollectionViewDelegate
extension EventViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.total ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        let temp = self.data?.events[indexPath.row]
        cell.setData(image: temp?.urlImage ?? "", title: temp?.title ?? "", subTitle: temp?.subTitle ?? "")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: heightOfCell)
    }
}

