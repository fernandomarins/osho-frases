//
//  Extensions.swift
//  Luz-Osho
//
//  Created by Fernando Augusto de Marins on 09/05/17.
//  Copyright © 2017 Fernando Augusto de Marins. All rights reserved.
//

import UIKit

extension AppDelegate {
    class func isIPhone5 () -> Bool{
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 568.0
    }
    class func isIPhone6 () -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 667.0
    }
    class func isIPhone6Plus () -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 736.0
    }
}
