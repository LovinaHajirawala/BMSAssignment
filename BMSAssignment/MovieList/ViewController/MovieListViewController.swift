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
    
    // MARK: Variables declarations
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 API call
        setMovieModel()
        // 2 To handle empty cells in tableview
        self.movieListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBarTextField.tintColor = .clear
        searchBarTextField.delegate = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setMovieModel(){
        self.viewModel.getMovieList(url: .movieList) { success, msg in
            if success {
                self.movieListTableView.reloadData()
            } else {
                self.presentAlertViewController(msg: COMMON_ERROR_MESSAGE)
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: BACK, style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .red
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentSearchScreenVC(){
        // 1
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        // 2
        let vc = storyboard.instantiateViewController(identifier: SEARCH_SCREEN_VIEWCONTROLLER) as! SearchScreenViewController
        // 3 pass data
        let movieName = self.viewModel.movieList?.first?.results?.compactMap{$0.original_title}
        vc.movieNameArray =  movieName ?? [""]
        // 6
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: BACK, style: .plain, target: self, action: nil)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
}
// end of class

//MARK: SearchBar Delegate
extension MovieListViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.presentSearchScreenVC()
        return false
    }
}
// end of UISearchBarDelegate extension


//MARK: UITableViewDataSource
extension MovieListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieList?.first?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1
        let cell = tableView.dequeueReusableCell(withIdentifier: MOVIE_LIST_SCREEN_CELL_IDENTIFIER, for: indexPath) as! MovieListTableViewCell
        // 2 set image
        cell.showImageFromUrl(path : viewModel.movieList?.first?.results?[indexPath.section].poster_path ?? "", indexpath: indexPath.section)
        // 3
        cell.configureUI(model: viewModel.movieList?.first?.results, indexpath: indexPath.section)
        // 4 button action
        cell.bookButton.whenButtonIsClicked {
            self.pushMovieDetailScreenVC(id: self.viewModel.movieList?.first?.results?[indexPath.section].id ?? 0)
        }
        return cell
    }
}
// end of UITableViewDataSource

//MARK: UITableViewDelegate
extension MovieListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushMovieDetailScreenVC(id: viewModel.movieList?.first?.results?[indexPath.section].id ?? 0)
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

