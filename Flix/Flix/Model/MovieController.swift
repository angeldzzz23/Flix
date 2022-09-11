//
//  MovieController.swift
//  Flix
//
//  Created by Angel Zambrano on 9/10/22.
//

import Foundation
import UIKit


class MenuController {
    
    let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!
    
    
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
