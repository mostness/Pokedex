//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Topness on 1/14/16.
//  Copyright © 2016 Symmary. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var currentPokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = currentPokemon.name
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nameLabel: UILabel!

}
