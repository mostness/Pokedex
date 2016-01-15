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
        let img = UIImage(named: "\(currentPokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        currentPokemon.downloadPokemonDetails { () -> () in
            //this is called after download is done
            self.updateUI()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateUI() {
        descriptionLbl.text = currentPokemon.description
        defenseLbl.text = currentPokemon.defense
        heightLbl.text = currentPokemon.height
        pokedexLbl.text = "\(currentPokemon.pokedexId)"
        weightLbl.text = currentPokemon.weight
        baseAttackLbl.text = currentPokemon.baseAttack
        typeLbl.text = currentPokemon.type
        
        if currentPokemon.nextEvolutionId == "" {
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.image = UIImage(named: currentPokemon.nextEvolutionId)
            nextEvoImg.hidden = false
        }
        
    }
}
