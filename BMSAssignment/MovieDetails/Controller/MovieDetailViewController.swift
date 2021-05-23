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
    
    // MARK: Variables declearations
    var movieId: Int!
    var movieSynopsis : MovieSynopsisResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 API Call
        getMovieSynopsis()
        // TODO: On click on homepage take to SFSafariVC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookButton.addBorderLayerAndCornerRadius(color: .clear)
    }
    
    //MARK:- API Call
    func getMovieSynopsis(){
        // TODO: start loader
        // 1 Set Parameters
        let parameters: [String: Int] = [:]
        // 2 Set Request
        let request = RequestModel(url: .movieSynopsis, httpBody: parameters, pathParam: "\(movieId ?? 0)")
        // 3  API Call
        NetworkManager.request(request, MovieSynopsisResponse.self) { result in
            // TODO: dismiss loader
            switch result {
            case .success(let list):
                //4 assign data to datasource
                self.movieSynopsis = list
                // 5 set UI
                DispatchQueue.main.async {
                    self.configureUI()
                }
            case .failure(let err):
                // 6 Error Handling
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
        movieName.text = "Movie Name: \(self.movieSynopsis?.original_title ?? "")"
        homepageLabel.text = "HomePage: \(self.movieSynopsis?.homepage ?? "")"
        languageLabel.text = "Language: \(self.movieSynopsis?.original_language ?? "")"
        taglineLabel.text = "Tagline: \(self.movieSynopsis?.tagline ?? "")"
        overviewLabel.text = "Overview: \(self.movieSynopsis?.overview ?? "")"
        releaseDateStatusLabel.text = "Release Date: \(self.movieSynopsis?.release_date ?? "")"
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


