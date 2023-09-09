//
//  MovieListCell.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import UIKit
import SwiftUI

class MovieListCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieVoteCount: UILabel!
    @IBOutlet weak var movieVoteAverage: UILabel!


    var id = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.layer.cornerRadius = movieImageView.frame.height / 16
        movieImageView.layer.borderWidth = 2
        movieImageView.layer.borderColor = ThemeManager.shared.theme.primaryColour.cgColor
        
    }
    
    
    func configureCell(model:ResultClass){
        id = model.id ?? 0
        movieName.text = model.originalTitle ?? ""
        movieDescription.text = model.overview ?? ""
        movieVoteCount.text = "\(model.voteCount ?? 0)"
        movieVoteAverage.text = "\(model.voteAverage ?? 0)"
        let imageUrl = AppManager.sharedInstance.imageURL(sizes: "w300", endpoint: model.backdropPath ?? "")
        movieImageView.kingFisherImage(Url: imageUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
