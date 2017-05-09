//
//  Phrase.swift
//  Luz-Osho
//
//  Created by Fernando Augusto de Marins on 09/05/17.
//  Copyright © 2017 Fernando Augusto de Marins. All rights reserved.
//

import Firebase

struct Phrase {
    
    let phrase: String?
    
    init(data: NSDictionary) {
        phrase = data["phrase"] as? String
    }
}
