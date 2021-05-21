//
//  MovieListViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 15/05/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var searchBarTextField: UISearchBar!
    @IBOutlet weak var movieListTableView: UITableView!
    
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
        getMovieList()
    }
    
    func showEmptyState(){
        
    }
    
    func hideEmptyState(){
        
    }
    
    func getMovieList(){
        let parameters: [String: String] = [:]
        let request = RequestModel(url: .movieList, httpBody: parameters, pathParam: "")
        NetworkManager.request(request, MovieListResponse.self) { result in
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
    

    func pushMovieDetailScreenVC(id: Int){
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: MOVIE_DETAIL_VIEWCONTROLLER) as! MovieDetailViewController
        vc.movieId = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
// end of class

extension MovieListViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.presentViewController(vcIdentifier: SEARCH_SCREEN_VIEWCONTROLLER)
        return true
    }
}

// end of UISearchBarDelegate extension

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

