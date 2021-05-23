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
    
    // MARK: Variables declearations
    var movieNameArray = [String]()
    var filteredArray = [String]()
    var searchText = String()
    var selectedMovies = [String]()
    var movies = [Movie]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var isSearching = Bool()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreDataObjects()
        
    }
    
    
    func fetchCoreDataObjects(){
       // fetch movies from core data to display in the tableview
        do {
            self.movies =  try context.fetch(Movie.fetchRequest())
            // Its an UI operation. dispatch to avoid performance impact
            DispatchQueue.main.async {
                self.searchStatusLabel.text = self.movies.isEmpty ? "" : RECENTLY_SEARCHED
                self.searchTableView.reloadData()
            }

        } catch {

        }
    }
    
    func cacheMoviesToCoreData(movieName: String){
        let movie = Movie(context: context)
        movie.movieName = selectedMovies
        do {
            try context.save()
        } catch {
            // error
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBarTextField.tintColor = .red
    }
    
//    func loadCoreData(){
//        context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: ENTITY_NAME, in: context)
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//        saveData(UserDBObj:newUser)
//    }
//
//    func saveData(UserDBObj:NSManagedObject)
//        {
//            UserDBObj.setValue(selectedMovies, forKey: ATTRIBUTE_NAME)
//
//            print("Storing Data..")
//            do {
//                try context.save()
//            } catch {
//                print("Storing data Failed")
//            }
//
//            fetchData()
//        }
//
//    func fetchData()
//        {
//            print("Fetching Data..")
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
//            request.returnsObjectsAsFaults = false
//            do {
//                let result = try context.fetch(request)
//                for data in result as! [NSManagedObject] {
//                    let userName = data.value(forKey: ATTRIBUTE_NAME) as! String
//                    print("User Name is : \(userName)")
//                }
//            } catch {
//                print("Fetching data Failed")
//            }
//        }
}
// end of class


extension SearchScreenViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  isSearching ? filteredArray.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_SCREEN_CELL_IDENTIFIER, for: indexPath) as! SearchScreenTableViewCell
        cell.addBorderLayerAndCornerRadius(color: .black)
        if  isSearching || movies.isEmpty {
            cell.configureUI(movie: filteredArray[indexPath.section], searchText: self.searchText)
            cell.isUserInteractionEnabled = true
        } else {
            let name = self.movies[indexPath.section]
            cell.configureUI(movie:  name.movieName?.first ?? "", searchText: self.searchText)
            cell.isUserInteractionEnabled = false
        }
      
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
        // hide search cancel button
        searchBarTextField.showsCancelButton = false
        //
        let movieArray = movies.compactMap{$0.movieName}
        let selectedMovieArray = movieArray.compactMap{$0.contains(filteredArray[indexPath.section])}
        if selectedMovieArray.contains(true) {
            self.presentAlertViewController(msg: ALREADY_CACHED)
        } else {
            selectedMovies.append(filteredArray[indexPath.section])
        }
       
        // create a movie object
        let cachedMovie = Movie(context: self.context)
        cachedMovie.movieName = selectedMovies
        // save to core data
        if selectedMovies.count <= 5 {
            cacheMoviesToCoreData(movieName: filteredArray[indexPath.section])
            self.presentAlertViewController(msg: CACHED)
        } else {
            self.presentAlertViewController(msg: CACHING_ERROR)
        }
    }
}

extension SearchScreenViewController : UISearchBarDelegate {
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        isSearching = true
//        searchBar.showsCancelButton = true
//        searchStatusLabel.text = ""
//        return true
//    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchBar.showsCancelButton = true
        searchStatusLabel.text = ""
        
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearching = true
        searchStatusLabel.text = ""
        filteredArray = movieNameArray
        self.searchTableView.reloadData()
    }
}






