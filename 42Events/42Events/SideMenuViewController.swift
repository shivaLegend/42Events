//
//  SideMenuViewController.swift
//  42Events
//
//  Created by Tai Nguyen on 20/05/2021.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    private let listTitle = ["Log in", "Sign up", "Guides and FAQ", "Contact us"]
    private let listIcon = [#imageLiteral(resourceName: "icons8-login_rounded_up"),#imageLiteral(resourceName: "icons8-sign_up"),#imageLiteral(resourceName: "icons8-question_mark"),#imageLiteral(resourceName: "icons8-headphones")]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    
    
    //MARK: - UI functions
    func initUI() {
        initTableView()
    }
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ItemInMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemInMenuTableViewCell")
        
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableView.contentSize.height
    }
    //MARK: - Handler functions
    @IBAction func languageBtn(_ sender: Any) {
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
