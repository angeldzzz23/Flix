//
//  MovieController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/10/22.
//

import Foundation
import UIKit



class MenuController {
    static let shared = MenuController()
    
    let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!


    func fetchCategories(completion: @escaping (Swift.Result<[Result], Error>) -> Void)
    {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let moviesResponse = try jsonDecoder.decode(Welcome.self, from: data)
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
//        let task = URLSession.shared.dataTask(with: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed") { (data, response, error) in
//            if let data = data {
//                do {
//                    let jsonDecoder = JSONDecoder()
//                    let categoriesResponse = try jsonDecoder.decode(CategoriesResponse.self, from: data)
//                    completion(.success(categoriesResponse.categories))
//                } catch {
//                    completion(.failure(error))
//                }
//            } else if let error = error {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
        
    }
    
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
