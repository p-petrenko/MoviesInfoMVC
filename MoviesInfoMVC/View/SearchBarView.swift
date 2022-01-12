//
//  SearchBarView.swift
//  MoviesInfoMVC
//
//  Created by Polina Petrenko on 04.01.2022.
//

import UIKit

class SearchBarView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: SearchBarViewDelegate? {
        didSet {
            if let text = searchBar.text {
                delegate?.searchBarTextChanged(text: text)
            }
        }
    }
    
    private (set) var searchText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(self.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        searchBar.delegate = self
        
        configureSearchBar()
    }
 
    func configureSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.text = "Guardians of the Galaxy"
        searchBar.placeholder = "Search for a movie"
    }
    
    
}

// MARK: - UISearchBarDelegate

extension SearchBarView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarTextChanged(text: searchText)
        self.searchText = searchText
    }
}

// MARK: - Create SearchBarViewDelegate Protocol

protocol SearchBarViewDelegate {
    func searchBarTextChanged(text: String)
}
