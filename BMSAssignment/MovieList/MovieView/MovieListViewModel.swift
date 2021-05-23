//
//  MovieListViewModel.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 23/05/21.
//

import Foundation
import UIKit

class MovieListViewModel {
    // MARK: Variables declarations
    var movieList : [MovieListResponse]?
    
    func didSetMovieList(completion: @escaping(Bool) -> ()){
        guard let movieLists = self.movieList, !movieLists.isEmpty else {
            self.showEmptyState()
            completion(false)
            return
        }
        self.hideEmptyState()
        completion(true)
    }
    
    func showEmptyState(){
        // TODO
    }
    
    func hideEmptyState(){
        // TODO
    }
    
    func getMovieList (url: EndPoint, completion: @escaping(Bool, String) -> ()){
        //1 show loader
        // 2 set request and param
        let parameters: [String: String] = [:]
        let request = RequestModel(url: .movieList, httpBody: parameters, pathParam: "")
        //3 make a request to NetworkManager
        NetworkManager.request(request) { (result: Result<MovieListResponse, APIError>) in
            //4 dismiss loader
            switch result {
            case .success(let list):
                self.movieList = [list]
                // 5 success completion
                DispatchQueue.main.async {
                    completion(true, "success")
                }
            case .failure(let err):
                // 6 failure completion
                DispatchQueue.main.async {
                    completion(false, err.localizedDescription)
                }
            }
        }
    }
}
// end of class
