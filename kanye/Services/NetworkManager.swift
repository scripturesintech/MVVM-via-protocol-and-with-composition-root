//
//  NetworkManager.swift
//  kanye
//
//  Created by ScripturesInTech on 19/01/23.
//

import Foundation

protocol NetworkProtocol {
    func fetchQuote(url: URL, complition: @escaping (Result<Quote, Error>) -> (Void))
}

class NetworkManager: NetworkProtocol {
    func fetchQuote(url: URL, complition: @escaping (Result<Quote, Error>) -> (Void)) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let quote = try JSONDecoder().decode(Quote.self, from: data)
                    complition(.success(quote))

                } catch let error {
                    complition(.failure(error))
                    debugPrint(error.localizedDescription)
                }
            }
        }.resume()
    }
}
