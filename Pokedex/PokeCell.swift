//
//  PokeCell.swift
//  Pokedex
//
//  Created by Topness on 1/13/16.
//  Copyright © 2016 Symmary. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var _pokemon: Pokemon!
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 4.0
        
    }
    
    func configureCell(pokemon: Pokemon) {
        _pokemon = pokemon
        nameLbl.text = _pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(_pokemon.pokedexId)")
    }
   

}
