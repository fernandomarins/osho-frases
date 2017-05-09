//
//  Phrases.swift
//  Luz-Osho
//
//  Created by Fernando Augusto de Marins on 09/05/17.
//  Copyright © 2017 Fernando Augusto de Marins. All rights reserved.
//

import Foundation

struct Phrases {
    var phrases = [Phrase]()
    
    static let sharedInstance = Phrases()
    private init(){}
}
