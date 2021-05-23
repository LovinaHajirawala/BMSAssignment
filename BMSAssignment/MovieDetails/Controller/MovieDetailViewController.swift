//
//  MovieDetailViewController.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import UIKit
import SDWebImage


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
    
    //MARK:- API Call
    func getMovieSynopsis(){
        let parameters: [String: Int] = [:]
        let request = RequestModel(url: .movieSynopsis, httpBody: parameters, pathParam: "\(movieId ?? 0)")
        NetworkManager.request(request, MovieSynopsisResponse.self) { result in
            switch result {
            case .success(let list):
                // assign data to datasource
                self.movieSynopsis = list
                // set UI
                DispatchQueue.main.async {
                    self.configureUI()
                }
            case .failure(let err):
                self.presentAlertViewController(msg: err.localizedDescription)
            }
        }
    }
    
    static func getPathParameter(movieId: Int) -> EndPoint{
        return .movieList
    }
    
    //MARK: Set UI
    func configureUI(){
        movieImageView.sd_setImage(with: getImageUrl(path: self.movieSynopsis?.backdrop_path ?? ""), placeholderImage: UIImage(named: "placeholder"))
        movieName.text = self.movieSynopsis?.original_title
        homepageLabel.text = self.movieSynopsis?.homepage
        languageLabel.text = self.movieSynopsis?.original_language
        taglineLabel.text = self.movieSynopsis?.tagline
        overviewLabel.text = self.movieSynopsis?.overview
        releaseDateStatusLabel.text = self.movieSynopsis?.release_date
        bookButton.addBorderLayerAndCornerRadius()
    }
    
    func getImageUrl(path: String) -> URL {
        let url = NSURL()
        let imageString = IMAGE_BASE_URL + path
        guard let imageUrl = URL(string: imageString.replacingOccurrences(of: " ", with: "%20")) else { return url as URL }
        return imageUrl
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookButtonClicked(_ sender: Any) {
        self.presentAlertViewController(msg: "View list of all theatres screening this.")
    }
    
}
//end of class


