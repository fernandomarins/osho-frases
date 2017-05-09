//
//  PhraseViewController.swift
//  Luz-Osho
//
//  Created by Fernando Augusto de Marins on 09/05/17.
//  Copyright © 2017 Fernando Augusto de Marins. All rights reserved.
//

import UIKit
import Firebase

class PhraseViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    fileprivate var ref: FIRDatabaseReference!
    fileprivate var _refHandle: FIRDatabaseHandle?
    
    var phrases = Phrases.sharedInstance.phrases

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatabase()
    }
    
    deinit {
        if let refHandle = _refHandle {
            ref.child("phrases").removeObserver(withHandle: refHandle)
        }
    }
    
    // Code got from CodeLab Google
    fileprivate func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = ref.child("phrases").observe(.childAdded, with: { [weak self] (snapshot) in
            guard let me = self else { return }
            
            let snapShotValue = snapshot.value as? NSDictionary
            if let data = snapShotValue {
                let phrase = Phrase(data: data)
                me.phrases.append(phrase)
            }
        })
    }
    
    @IBAction func getPhrase(_ sender: Any) {
        
        let lower = 0
        let upper = phrases.count
        let number = arc4random_uniform(UInt32(upper - lower)) + UInt32(lower)
        
        print(phrases.count)
        print(number)
        
        textView.text = phrases[Int(number)].phrase
    }
}
