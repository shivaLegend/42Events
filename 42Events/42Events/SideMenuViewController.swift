//
//  SideMenuViewController.swift
//  42Events
//
//  Created by Tai Nguyen on 20/05/2021.
//

import UIKit
import DropDown
class SideMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var languageLbl: UILabel!
    private let dropDown = DropDown()
    private let listTitle = ["Log in", "Sign up", "Guides and FAQ", "Contact us"]
    private let listIcon = [#imageLiteral(resourceName: "icons8-login_rounded_up"),#imageLiteral(resourceName: "icons8-sign_up"),#imageLiteral(resourceName: "icons8-question_mark"),#imageLiteral(resourceName: "icons8-headphones")]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    
    
    //MARK: - UI functions
    func initUI() {
        initTableView()
        initDropDownView()
    }
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ItemInMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemInMenuTableViewCell")
        
    }
    func initDropDownView() {
        dropDown.backgroundColor = .white
        dropDown.anchorView = self.languageLbl
        let source : [String] = ["English", "日本語","ภาษาไทย","Bahasa Indonesia", "Tiếng Việt"]
        dropDown.dataSource = source
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.languageLbl.text = item
        }
        DropDown.appearance().setupCornerRadius(10)
        dropDown.textFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableView.contentSize.height
    }
    //MARK: - Handler functions
    @IBAction func languageBtn(_ sender: Any) {
        dropDown.show()
    }
    
    //MARK: - API functions

}
//MARK: -UITableViewDelegate, UITableViewDataSource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemInMenuTableViewCell") as! ItemInMenuTableViewCell
        cell.setData(text: listTitle[indexPath.row], img: listIcon[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
