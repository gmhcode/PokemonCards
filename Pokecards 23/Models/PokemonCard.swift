//
//  PokemonCard.swift
//  Pokecards 23
//
//  Created by Greg Hughes on 12/13/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable{
    
    let cards : [PokemonCard]
    
    
}

struct PokemonCard: Decodable{
    
    let imageUrl: URL
    let attacks : [Attack]?
    
}

struct Attack: Decodable {
    
    let name : String
    let damage : String
    let convertedEnergyCost : Int
    
}
