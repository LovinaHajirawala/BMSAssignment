//
//  MovieListTableViewCell.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 15/05/21.
//

import UIKit
import SDWebImage

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
        self.addBorderLayerAndCornerRadius(color: .black)
        self.movieImageView?.addBorderLayerAndCornerRadius(color: .black)
        self.bookButton.addBorderLayerAndCornerRadius(color: .red)
        // 2 data binding
        self.movieNameLabel.text = model?[indexpath].original_title
        self.releaseDateLabel.text = "Release Date: \(model?[indexpath].release_date ?? "")"
        self.languageLabel.text = "Language: \(model?[indexpath].original_language ?? "")"
        self.ratingsLabel.text = "Ratings: \(model?[indexpath].vote_count ?? 0)"
    }
    
    func showImageFromUrl(path : String, indexpath: Int){
        //1
        self.movieImageView.layer.masksToBounds = true
        // 2 set image url
        let imageString = IMAGE_BASE_URL + path
        let imageUrl = URL(string: imageString.replacingOccurrences(of: " ", with: "%20"))
        guard let url = imageUrl else { return }
        // 3 assign sdwebimage
        movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }
}
// end of class
