//
//  MovieDetail.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 24/05/21.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    // MARK: Variables declarations
    var movieId: Int!
    var movieSynopsis : MovieSynopsisResponse?

    
  func getImageUrl(path: String) -> URL {
        let url = NSURL()
        let imageString = IMAGE_BASE_URL + path
        guard let imageUrl = URL(string: imageString.replacingOccurrences(of: " ", with: "%20")) else { return url as URL }
        return imageUrl
    }
    
    static func getPathParameter(movieId: Int) -> EndPoint{
        return .movieList
    }
    
    func getMovieSynopsis(completion: @escaping(Bool, String)-> ()){
        // TODO: start loader
        // 1 Set Parameters
        let parameters: [String: Int] = [:]
        // 2 Set Request
        let request = RequestModel(url: .movieSynopsis, httpBody: parameters, pathParam: "\(movieId ?? 0)", requestType: .GET)
        // 3  API Call
        NetworkManager.request(request) { (result: Result<MovieSynopsisResponse, APIError>) in
            // TODO: dismiss loader
            switch result {
            case .success(let list):
                //4 assign data to datasource
                self.movieSynopsis = list
                // 5 set UI
                completion(true, "success")
            case .failure(let err):
                // 6 Error Handling
                completion(true, err.localizedDescription)
            }
        }
    }
    
}
// end of class
