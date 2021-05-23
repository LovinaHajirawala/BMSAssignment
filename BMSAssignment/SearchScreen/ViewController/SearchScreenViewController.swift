//
//  SearchScreenViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import UIKit
import CoreData

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchStatusLabel: UILabel!
    @IBOutlet weak var searchBarTextField: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: Variables declarations
    var movieNameArray = [String]()
    var filteredArray = [String]()
    var searchText = String()
    var selectedMovies = [String]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var isSearching = Bool()
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 fetch core data objects
        fetchCoreDataObjectsFromModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBarTextField.tintColor = .red
    }
    
    func fetchCoreDataObjectsFromModel(){
        self.viewModel.fetchCoreDataObjects { success in
            if success {
                // do block success
                self.searchStatusLabel.text = self.viewModel.movies.isEmpty ? "" : RECENTLY_SEARCHED
                self.searchTableView.reloadData()
            } else {
                // catch block
                self.presentAlertViewController(msg: COMMON_ERROR_MESSAGE)
            }
        }
    }
    
    func cacheMoviesToCoreDataFromModel(){
        self.viewModel.cacheMoviesToCoreData{ success in
            if success{
                // do block success
                self.presentAlertViewController(msg: CACHED)
            } else {
                // catch block
            }
        }
    }
}
// end of class

//MARK: UITableViewDataSource extension
extension SearchScreenViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.movies.count == 0 && filteredArray.count == 0{
            return movieNameArray.count
        }
        return  isSearching ? filteredArray.count : viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_SCREEN_CELL_IDENTIFIER, for: indexPath) as! SearchScreenTableViewCell
        cell.addBorderLayerAndCornerRadius(color: .black)
        if  isSearching {
            cell.configureUI(movie: filteredArray[indexPath.section], searchText: self.searchText)
            cell.isUserInteractionEnabled = true
        } else if viewModel.movies.count == 0 && filteredArray.count == 0 {
            cell.configureUI(movie: movieNameArray[indexPath.section], searchText: self.searchText)
            cell.isUserInteractionEnabled = true
        }
        else {
            // from core data
            let name = viewModel.movies[indexPath.section]
            cell.configureUI(movie:  name.movieName?[indexPath.section] ?? "", searchText: self.searchText)
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
}
//end of UITableViewDataSource extension

//MARK: UITableViewDelegate extension
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
        //1 hide search cancel button
        searchBarTextField.showsCancelButton = false
        //2 filter data
        let movieArray = viewModel.movies.compactMap{$0.movieName}
        let selectedMovieArray = movieArray.compactMap{$0.contains(filteredArray[indexPath.section])}
        // 3 check if already exist
        if selectedMovieArray.contains(true) {
            self.presentAlertViewController(msg: ALREADY_CACHED)
            // 4
            return
        } else if !filteredArray.isEmpty{
            selectedMovies.append(filteredArray[indexPath.section])
        } else {
            selectedMovies.append(movieNameArray[indexPath.section])
        }
       // 5
        self.viewModel.validateMovie(selectedMovies: selectedMovies) { status, msg in
            if status {
                self.cacheMoviesToCoreDataFromModel()
            }
            self.presentAlertViewController(msg: msg)
        }
    }
}
// end of UITableViewDelegate extension

//MARK: UISearchBarDelegate extension
extension SearchScreenViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 1 UI Modification
        isSearching = true
        searchBar.showsCancelButton = true
        searchStatusLabel.text = ""
        // 2 data filteration
        filteredArray = searchText.isEmpty ? movieNameArray : movieNameArray.filter({(movie: String) -> Bool in
            // 3
            let movieSubparts = movie.components(separatedBy: " ")
            let movieFirstChar = movieSubparts.compactMap{$0.starts(with: searchText)}
            let filteredMovie =  movieFirstChar.filter{$0 == true}
            
            //4 If dataItem matches the searchText, return true to include it
            if !filteredMovie.isEmpty{
                return movie.range(of: searchText, options: .caseInsensitive) != nil
            }
            // 5
            return false
        })
        // 6
        self.searchText = searchText
        print(filteredArray)
        // 7 reload
        self.searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 1 UI Modification
        searchBar.showsCancelButton = false
        isSearching = true
        searchStatusLabel.text = ""
        // 2 assign original list
        filteredArray = movieNameArray
        // 3 reload
        self.searchTableView.reloadData()
    }
}
// end of UISearchBarDelegate extension






