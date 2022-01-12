//
//  MovieSearchViewController.swift
//  MoviesInfoMVC
//
//  Created by Polina Petrenko on 04.01.2022.
//

import UIKit

/// На этом экране происхоодит поиск фильма по названию и отображение списка найденных фильмов
class MovieSearchViewController: UIViewController {

    @IBOutlet weak var searchBarView: SearchBarView!
    @IBOutlet weak var tableView: UITableView!
    
    private var moviesSearchResult = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.keyboardDismissMode = .onDrag
        
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellReuseIdentifier: MovieCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension MovieSearchViewController: SearchBarViewDelegate {
    
    func searchBarTextChanged(text: String) {
        let searchTextChanged = (text != self.searchBarView.searchText)
        if searchTextChanged && !text.isEmpty {
            DispatchQueue.global().async {
                TMDBManager.getMoviesForSearchString(searchText: text) { moviesArray in
                    DispatchQueue.main.async { [weak self] in
                        self?.moviesSearchResult = moviesArray
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as! MovieCell
        let movie = moviesSearchResult[indexPath.row]
        cell.update(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = moviesSearchResult[indexPath.row]
        let vc = MovieDetailViewController.createWith(movie: selectedMovie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

