//
//  MovieDetailViewController.swift
//  MoviesInfoMVC
//
//  Created by Polina Petrenko on 11.01.2022.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var userScore: UILabel!
    
    var movie: Movie!
    
    static func createWith(movie: Movie) -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(ofType: MovieDetailViewController.self)
        vc.movie = movie
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        updateUI()
    }
    
    private func updateUI() {
        if let movieUnwrapped = self.movie {
            title = movieUnwrapped.title
            userScore.text = (movieUnwrapped.voteAverage != nil) ? "User score: \((movieUnwrapped.voteAverage!) * 10)%" : ""
            overviewTextView.text = movieUnwrapped.overview ?? ""
            filmImageView.kf.setImage(with: movieUnwrapped.getPosterURL())
        }
    }
    
}
