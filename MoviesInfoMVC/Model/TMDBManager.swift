
//
//  TMDBNetwork.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 12/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation
import Alamofire

struct TMDBManager {
   
    // MARK: - API Addresses
    fileprivate enum Address: String {
        case movieList = "search/movie"
        
        private var baseURL: String { return "https://api.themoviedb.org/3/" }
        var url: URL {
            return URL(string: baseURL.appending(rawValue))!
        }
    }
    
    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
    }
    
    static func getMoviesForSearchString(searchText: String, completion: @escaping ([Movie]) -> Void) {        
        let address = Address.movieList
        var params = [ParameterKeys.query: searchText]
        // add API key parameter
        params[ParameterKeys.ApiKey] = Constants.ApiKey
        // generate URL
        var comps = URLComponents(string: address.url.absoluteString)!
        comps.queryItems = params.map(URLQueryItem.init)
        let url = try! comps.asURL()
        
        let request = AF.request(url.absoluteString,
                                        method: .get,
                                        encoding: URLEncoding.httpBody,
                                        headers: nil)
                        .validate()

        request.responseDecodable(of: Movies.self) { (response) in
            guard let films = response.value else {
                completion([])
                return
            }
            print("Got getMoviesForSearchString Response: \n\(response)\n\n")
            completion(films.all)
        }
    }
   

}
