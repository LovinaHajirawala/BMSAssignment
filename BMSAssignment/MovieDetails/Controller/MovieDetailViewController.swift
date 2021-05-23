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
    
    // MARK: Variables declarations
    var movieId: Int!
    var viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 API Call
        self.viewModel.movieId = movieId
        getMovieSynopsisFromModel()
        // TODO: On click on homepage take to SFSafariVC/WKWebkit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookButton.addBorderLayerAndCornerRadius(color: .clear)
    }
    
    //MARK:- API Call
    func getMovieSynopsisFromModel(){
        // TODO: start loader
        // call viewmodel
        self.viewModel.getMovieSynopsis { status, msg in
            // dismiss loader
            if status {
                DispatchQueue.main.async {
                    self.configureUI()
                }
            } else {
                self.presentAlertViewController(msg: msg)
            }
        }
    }
    
   
    
    //MARK: Set UI
    func configureUI(){
        let path = self.viewModel.getImageUrl(path: self.viewModel.movieSynopsis?.backdrop_path ?? "")
        movieImageView.sd_setImage(with: path, placeholderImage: UIImage(named: "placeholder"))
        movieName.text = "Movie Name: \(self.viewModel.movieSynopsis?.original_title ?? "")"
        homepageLabel.text = "HomePage: \(self.viewModel.movieSynopsis?.homepage ?? "")"
        languageLabel.text = "Language: \(self.viewModel.movieSynopsis?.original_language ?? "")"
        taglineLabel.text = "Tagline: \(self.viewModel.movieSynopsis?.tagline ?? "")"
        overviewLabel.text = "Overview: \(self.viewModel.movieSynopsis?.overview ?? "")"
        releaseDateStatusLabel.text = "Release Date: \(self.viewModel.movieSynopsis?.release_date ?? "")"
    }
    
    //MARK: IBActions
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookButtonClicked(_ sender: Any) {
        self.presentAlertViewController(msg: "View list of all theatres screening this.")
    }
    
}
//end of class


