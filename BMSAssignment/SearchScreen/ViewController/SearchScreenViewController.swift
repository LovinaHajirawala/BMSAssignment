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
    var filteredArray = [String]()
    var searchText = String()
    var selectedMovies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchStatusLabel.text = selectedMovies.isEmpty ? "" : RECENTLY_SEARCHED
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBarTextField.tintColor = .red
    }
    
}
// end of class


extension SearchScreenViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_SCREEN_CELL_IDENTIFIER, for: indexPath) as! SearchScreenTableViewCell
        cell.addBorderLayerAndCornerRadius()
        cell.configureUI(movie: filteredArray[indexPath.section], searchText: self.searchText)
        return cell
    }

}

extension SearchScreenViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovies.append(filteredArray[indexPath.section])
        self.presentAlertViewController(msg: CACHED)
    }
}

extension SearchScreenViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = searchText.isEmpty ? movieNameArray : movieNameArray.filter({(movie: String) -> Bool in
            let movieSubparts = movie.components(separatedBy: " ")
            let movieFirstChar = movieSubparts.compactMap{$0.starts(with: searchText)}
            let filteredMovie =  movieFirstChar.filter{$0 == true}
            
            // If dataItem matches the searchText, return true to include it
            if !filteredMovie.isEmpty{
                return movie.range(of: searchText, options: .caseInsensitive) != nil
            }
           
            return false
            })
        self.searchText = searchText
        print(filteredArray)
        self.searchTableView.reloadData()
    }
}
