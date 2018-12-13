//
//  PokemonCard Controller.swift
//  Pokecards 23
//
//  Created by Greg Hughes on 12/13/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation
import UIKit

class PokemonCardController {
    
    static let baseUrl = URL(string: "https://api.pokemontcg.io")
    
    static func fetchCards(searchTerm: String, completion: @escaping ([PokemonCard]?) -> Void){
        
        guard var url = baseUrl else {completion(nil) ; return}
        
        url.appendPathComponent("v1")
        url.appendPathComponent("cards")
        
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let nameQueryItem = URLQueryItem(name: "name", value: searchTerm)
//        let queryItem = URLQueryItem(name: "id", value: "4562")
//        components?.queryItems = [nameQueryItem, queryItem]
        components?.queryItems = [nameQueryItem]
        
        guard let requestUrl = components?.url else {completion(nil) ; return}
        
        print(url)
        
//       https://api.pokemontcg.io/v1/cards?name=pikachu
        var request = URLRequest(url: requestUrl)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil) ; return}
            
            do {
                
                let jsonDecoder = JSONDecoder()
                let topLevelDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                let cards = topLevelDictionary.cards
                completion(cards)
            }
            catch{
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
            }
            
            
        }.resume()
    }
    
    
    static func fetchPokemonImage(with card: PokemonCard, completion: @escaping (UIImage?) -> Void ){
        
        let url = card.imageUrl
        
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil) ; return}
            
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
    
    
}
