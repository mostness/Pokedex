//
//  Pokemon.swift
//  Pokedex
//
//  Created by Topness on 1/13/16.
//  Copyright © 2016 Symmary. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonUrl: String!
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId)/"
        
    }
    
    var weight: String {
        get{
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    
    var baseAttack: String {
        get{
            if _baseAttack == nil {
                _baseAttack = ""
            }
            return _baseAttack
        }
    }
    
    var nextEvolutionTxt: String {
        get{
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
            return _nextEvolutionTxt
        }
    }
    
    var nextEvolutionId: String {
        get{
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            return _nextEvolutionId
        }
    }
    
    var nextEvolutionLevel: String {
        get{
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
            return _nextEvolutionLevel
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
    
    var description: String {
        get{
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }
    
    var type: String {
        get{
            if _type == nil {
                _type = ""
            }
            return _type
        }
    }
    
    var defense: String {
        get{
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    
    var height: String {
        get{
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON {
            response in let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let baseAttack = dict["attack"] as? Int {
                    self._baseAttack = "\(baseAttack)"
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    self._type = ""
                    for var x = 0; x < types.count; x++ {
                        if let name = types[x]["name"] {
                            self._type! += "\(name)"
                        }
                        if x < (types.count - 1) {
                            self._type! += " / "
                        }
                        
                    }
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON(completionHandler: { response in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        })
                    }
                    
                } else {
                    self._description = "No description."
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let evolveTo = evolutions[0]["to"] as? String {
                        if evolveTo.rangeOfString("mega") == nil {
                            //not mega
                            self._nextEvolutionTxt = evolveTo
                            if let evolveToUri = evolutions[0]["resource_uri"] as? String {
                                let newStr = evolveToUri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let evolveToID = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = evolveToID
                            }
                            if let lvl = evolutions[0]["level"] as? Int {
                                self._nextEvolutionLevel = "\(lvl)"
                            }
                        } else {
                            self._nextEvolutionId = nil
                        }
                    }
                }
                
                //print(self._type)
                //print(self._weight)
                //print(self._baseAttack)
                //print(self._height)
                //print(self._defense)
                //print(self._nextEvolutionId)
                //print(self._nextEvolutionTxt)
                //print(self._nextEvolutionLevel)
                
                
                
            }
        }
    }
    
}