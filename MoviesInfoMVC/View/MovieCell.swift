//
//  MovieCell.swift
//  MoviesInfoMVC
//
//  Created by Polina Petrenko on 06.01.2022.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!

    func update(with movie: Movie) {
        let releaseDate = movie.getReleaseDate()
        let releaseYearString = (releaseDate != nil) ? " (\(releaseDate!.year))" : ""
        title.text = movie.title + releaseYearString
        overview.text = movie.overview
        photo.image = UIImage(systemName: "calendar")
        photo.kf.setImage(with: movie.getPosterURL())
    }
}
