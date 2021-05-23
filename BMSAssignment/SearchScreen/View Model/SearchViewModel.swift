//
//  SearchViewModel.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 23/05/21.
//

import Foundation
import UIKit

class SearchViewModel {
    // MARK: Variables declarations
    var movies = [Movie]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func fetchCoreDataObjects(completion: @escaping(Bool)->()){
        //1 fetch movies from core data to display in the tableview
        do {
            self.movies =  try context.fetch(Movie.fetchRequest())
            //2
            completion(true)
        } catch {
            // handle error
            completion(false)
        }
    }
    
    func cacheMoviesToCoreData(completion: @escaping(Bool)->()){
        //1
        do {
            // 2 save
            try context.save()
            completion(true)
        } catch {
            // error
            completion(false)
        }
    }
    
    func validateMovie(selectedMovies : [String], completion: @escaping(Bool, String)->()){
        // 1 check
        if selectedMovies.count <= 5 {
            //2 create a movie object
            let cachedMovie = Movie(context: self.context)
            cachedMovie.movieName = selectedMovies
            //3 save to core data
            completion(true, CACHED)
        }
        else {
            // 4 validation on more than 5
            completion(false, CACHING_VALIDATION)
        }
    }
}
// end of class
