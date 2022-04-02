//
//  Service.swift
//  RequestsCache
//
//  Created by Alexander Avdacev on 2.04.22.
//

import Foundation

enum postResult {
    case success(posts: [Post])
    case failure(error: Error)
}

class Service {
    
    static let shared = Service()
    
    let sessionConfiguration    = URLSessionConfiguration.default
    let session                 = URLSession.shared
    let decoder                 = JSONDecoder()
    
    func fetchData(completion: @escaping (postResult) -> Void ) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            var result: postResult
            
            defer {                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
                        
            guard let self = self else {
                result = .success(posts: [])
                return
            }
            
            if error == nil, let parsData = data {
                guard let post = try? self.decoder.decode([Post].self, from: parsData)
                else {
                    result = .success(posts: [])
                    return
                }
                result = .success(posts: post)
            }
            else {
                result = .failure(error: error!)
            }
        }.resume()
    }
}
