//
//  CardsTableViewController.swift
//  Pokecards 23
//
//  Created by Greg Hughes on 12/13/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class CardsTableViewController: UITableViewController {
    
    var pokemonCards : [PokemonCard] = []
    
    // MARK: - ViewLifeycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = searchController
        
    }
    
    // MARK: - Setup
    
    
    
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonCards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as! PokemonCardTableViewCell
        
        let pokemonCard = pokemonCards[indexPath.row]
        
        cell.pokemonCard = pokemonCard
        //^^ didSet

        // Configure the cell...

        return cell
    }
 
}

extension CardsTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchTerm = searchBar.text ?? ""
        
        PokemonCardController.fetchCards(searchTerm: searchTerm) { (pokemonCards) in
            
            guard let fetchedPokemonCards = pokemonCards else {return}
            
            self.pokemonCards = fetchedPokemonCards
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
    }
}
