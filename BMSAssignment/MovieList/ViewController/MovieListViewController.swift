//
//  MovieListViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 15/05/21.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController {

    @IBOutlet weak var searchBarTextField: UISearchBar!
    @IBOutlet weak var movieListTableView: UITableView!
    
    // MARK: Variables declearations
    var movieList : [MovieListResponse]? {
        didSet {
            guard let movieLists = self.movieList, !movieLists.isEmpty else {
                self.showEmptyState()
                return
            }
            self.hideEmptyState()
            DispatchQueue.main.async {
                self.movieListTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 API call
        getMovieList()
        // 2 To handle empty cells in tableview
        self.movieListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBarTextField.tintColor = .clear
    }
    
    func showEmptyState(){
        // TODO
    }
    
    func hideEmptyState(){
        // TODO
    }
    
    func getMovieList(){
        //1 show loader
        let parameters: [String: String] = [:]
        let request = RequestModel(url: .movieList, httpBody: parameters, pathParam: "")
        NetworkManager.request(request, MovieListResponse.self) { result in
            //2 dismiss loader
            switch result {
            case .success(let list):
                self.movieList = [list]
            case .failure(let err):
                DispatchQueue.main.async {
                    self.presentAlertViewController(msg: err.localizedDescription)
                }
            }
        }
    }
    
    //MARK: Navigation methods
    func pushMovieDetailScreenVC(id: Int){
        // 1
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        // 2
        let vc = storyboard.instantiateViewController(identifier: MOVIE_DETAIL_VIEWCONTROLLER) as! MovieDetailViewController
        // 3 pass data
        vc.movieId = id
        // 4 push through navigation controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func presentSearchScreenVC(){
        // 1
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        // 2
        let vc = storyboard.instantiateViewController(identifier: SEARCH_SCREEN_VIEWCONTROLLER) as! SearchScreenViewController
        // 3 pass data
        let movieName = self.movieList?.first?.results?.compactMap{$0.original_title}
        vc.movieNameArray =  movieName ?? [""]
        // 5
        self.present(vc, animated: true, completion: nil)
    }
    
}
// end of class

//MARK: SearchBar Delegate
extension MovieListViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.presentSearchScreenVC()
    }
}
// end of extension

// end of UISearchBarDelegate extension
//MARK: UITableViewDataSource
extension MovieListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieList?.first?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MOVIE_LIST_SCREEN_CELL_IDENTIFIER, for: indexPath) as! MovieListTableViewCell
        cell.tag = indexPath.row
        cell.showImageFromUrl(path : movieList?.first?.results?[indexPath.section].poster_path ?? "", indexpath: indexPath.section)
        cell.configureUI(model: movieList?.first?.results, indexpath: indexPath.section)
        cell.bookButton.tag = indexPath.row
        cell.bookButton.whenButtonIsClicked {
            self.pushMovieDetailScreenVC(id: self.movieList?.first?.results?[indexPath.section].id ?? 0)
        }
        return cell
    }
}
// end of UITableViewDataSource

//MARK: UITableViewDelegate
extension MovieListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushMovieDetailScreenVC(id: movieList?.first?.results?[indexPath.section].id ?? 0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
// end of UITableViewDelegate

