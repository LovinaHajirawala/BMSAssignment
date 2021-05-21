//
//  MovieDetailViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var releaseDateStatusLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    
    var movieId: Int!
    var movieSynopsis : MovieSynopsisResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieSynopsis()
    }
    
    func getMovieSynopsis(){
        let parameters: [String: Int] = [:]
        let request = RequestModel(url: .movieSynopsis, httpBody: parameters, pathParam: "\(movieId ?? 0)")
        NetworkManager.request(request, MovieSynopsisResponse.self) { result in
            switch result {
            case .success(let list):
                self.movieSynopsis = list
            case .failure(let err):
                self.presentAlertViewController(msg: err.localizedDescription)
            }
        }
    }
    
    static func getPathParameter(movieId: Int) -> EndPoint{
        return .movieList
    }
    
}
//end of class


