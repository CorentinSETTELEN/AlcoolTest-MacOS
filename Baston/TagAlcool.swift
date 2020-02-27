//
//  TagAlcool.swift
//  Baston
//
//  Created by Corentin on 29/01/2020.
//  Copyright © 2020 Corentin. All rights reserved.
//

import Foundation

class TagAlcool {
    var id: Int = 0
    var nom: String = ""
    var list = [Alcool]()
    var nombre: Int = 0
    var red:Int = 0
    var green:Int = 0
    var blue:Int = 0

    // var age: Int = 0
    // var adresse: String
    
    // ...
    init(nom: String, id: Int, red: Int, green: Int, blue: Int) {
        self.nom = nom
        self.id = id
        self.red = red
        self.green = green
        self.blue = blue
    }
    // ...
}
