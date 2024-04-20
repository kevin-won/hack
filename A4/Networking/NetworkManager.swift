//
//  NetworkManager.swift
//  A4
//
//  Created by Kevin Won on 4/20/24.
//

import Alamofire
import Foundation

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }

    /// Endpoint for dev server
    private let devEndpoint: String = "https://api.jsonbin.io/v3/b/64d033f18e4aa6225ecbcf9f?meta=false"

    // MARK: - Requests
    
    /**
     Fetch the  posts from the backend
     */
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        // Create a decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Create the request
        AF.request(devEndpoint, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder) { response in
                switch response.result {
                case .success(let recipes):
                    print("Successfully fetched \(recipes.count) recipes")
                    completion(recipes)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRoster: \(error.localizedDescription)")
                }
            }
    }
    
   
}
