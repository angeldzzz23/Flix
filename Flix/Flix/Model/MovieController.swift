//
//  MovieController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/10/22.
//

import Foundation
import UIKit


/// this controller is in charge of handling our API Requests
class MovieController {
    
    static let shared = MovieController()
    

    private let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
    
    /// Gets the movies from the url
    func fetchMovies(completion: @escaping (Swift.Result<[Result], Error>) -> Void)
    {
       
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let moviesResponse = try jsonDecoder.decode(Response.self, from: data)
                    completion(.success(moviesResponse.results))
                }
                catch {
                    completion(.failure(error))
                }
            } else {
                print("no data")
            }
        }
        task.resume()
        
    }
    
    /// dowloads image given a url 
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
}
