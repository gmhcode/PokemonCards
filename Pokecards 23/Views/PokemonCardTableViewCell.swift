//
//  PokemonCardTableViewCell.swift
//  Pokecards 23
//
//  Created by Greg Hughes on 12/13/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class PokemonCardTableViewCell: UITableViewCell {

// MARK: - Properties

    @IBOutlet weak var pokemonCardImageView: UIImageView!
    
    var pokemonCard : PokemonCard? {
        
        didSet {
            updateViews()
        }
    }
    
    
    
    
    // MARK: - setup
    func updateViews(){
        
        guard let pokemonCard = pokemonCard else {return}
        
        PokemonCardController.fetchPokemonImage(with: pokemonCard) { (image) in
            
            DispatchQueue.main.async {
                
                self.pokemonCardImageView.image = image
            }
        }
    }
    
    
    
    
}
