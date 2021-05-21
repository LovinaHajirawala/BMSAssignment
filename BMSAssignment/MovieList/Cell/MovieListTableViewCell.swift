//
//  MovieListTableViewCell.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 15/05/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var bookButton: CustomButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureUI(model: [Results]?, indexpath: Int){
        // 1 UI set up
        self.addBorderLayer()
        self.movieImageView?.addBorderLayer()
        self.bookButton.addBorderLayer()
        // 2 data binding
        self.movieNameLabel.text = model?[indexpath].original_title
        self.releaseDateLabel.text = "Release Date: \(model?[indexpath].release_date ?? "")"
        self.languageLabel.text = "Language: \(model?[indexpath].original_language ?? "")"
        self.ratingsLabel.text = "Ratings: \(model?[indexpath].vote_count ?? 0)"
    }
    
    func showImageFromUrl(path : String, indexpath: Int){
        self.movieImageView.layer.masksToBounds = true
        DispatchQueue.main.async {
            if(self.tag == indexpath) {
                if !path.isEmpty{
                    self.movieImageView.downloaded(from: path)
                } else {
                    self.movieImageView.image = #imageLiteral(resourceName: "placeholder.jpg")
                }
            }
        }
    }
}
// end of class
