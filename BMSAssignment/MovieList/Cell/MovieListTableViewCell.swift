//
//  MovieListTableViewCell.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 15/05/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: IBACTIONS
    @IBAction func bookButtonTapped(_ sender: Any) {
    }
    

}
// end of class
