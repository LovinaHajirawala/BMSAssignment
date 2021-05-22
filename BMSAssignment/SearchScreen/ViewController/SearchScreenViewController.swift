//
//  SearchScreenViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import UIKit

class SearchScreenViewController: UIViewController {

    @IBOutlet weak var searchStatusLabel: UILabel!
    @IBOutlet weak var searchBarTextField: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var movieNameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
// end of class


extension SearchScreenViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieNameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_SCREEN_CELL_IDENTIFIER, for: indexPath) as! SearchScreenTableViewCell
        cell.addBorderLayerAndCornerRadius()
        cell.movieNameLabel.text = movieNameArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension SearchScreenViewController : UITableViewDelegate {
    
}
