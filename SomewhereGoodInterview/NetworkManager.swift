//
//  NetworkManager.swift
//  SomewhereGoodInterview
//
//  Created by Vanessa Flores on 1/15/21.
//

import Foundation

enum SGError: String, Error {
    case connectivity = "Connectivity error."
    case invalidResponse = "Invalid Respsonse error."
    case invalidData = "Invalid data error."
}

class NetworkManager {
    
    func fetchDirectMessages(completion: @escaping (Result<Model, SGError>) -> Void) {
        let endpoint = "https://lgb8ppx4e5.execute-api.us-east-1.amazonaws.com/dev/messages"
        
        guard let url = URL(string: endpoint) else {
            preconditionFailure("Not a valid url.")
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.connectivity))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let model = try decoder.decode(Model.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
