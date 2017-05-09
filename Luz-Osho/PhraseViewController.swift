//
//  PhraseViewController.swift
//  Luz-Osho
//
//  Created by Fernando Augusto de Marins on 09/05/17.
//  Copyright © 2017 Fernando Augusto de Marins. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class PhraseViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var newPhraseButton: UIButton!
    
    fileprivate var ref: FIRDatabaseReference!
    fileprivate var _refHandle: FIRDatabaseHandle?
    fileprivate(set) var currentHud: MBProgressHUD?
    
    var phrases = Phrases.sharedInstance.phrases

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        newPhraseButton.isHidden = true
        textView.delegate = self
        textView.sizeToFit()
        setUI()
        configureDatabase()
    }
    
    deinit {
        if let refHandle = _refHandle {
            ref.child("phrases").removeObserver(withHandle: refHandle)
        }
    }
    
    fileprivate func setUI() {
        if AppDelegate.isIPhone5() {
            titleText.font = UIFont(name: "Roboto-Regular", size: 45)
            textView.font = UIFont(name: "Roboto-Regular", size: 20)
            newPhraseButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        }
        
        if AppDelegate.isIPhone6() {
            titleText.font = UIFont(name: "Roboto-Regular", size: 50)
            textView.font = UIFont(name: "Roboto-Regular", size: 25)
            newPhraseButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        }
        
        if AppDelegate.isIPhone6Plus() {
            titleText.font = UIFont(name: "Roboto-Regular", size: 55)
            textView.font = UIFont(name: "Roboto-Regular", size: 30)
            newPhraseButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)
        }
    }
    
    // Code got from CodeLab Google
    fileprivate func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        
        hudShow(message: "Baixando frases...")

        _refHandle = ref.child("phrases").observe(.childAdded, with: {
            
            [weak self] (snapshot) in
            
            guard let me = self else { return }
            
            me.hudDismiss()
            
            let snapShotValue = snapshot.value as? NSDictionary
            if let data = snapShotValue {
                let phrase = Phrase(data: data)
                me.phrases.append(phrase)
                me.textView.text = me.phrases[0].phrase
                me.newPhraseButton.isHidden = false
            }
        })
    }
    
    fileprivate func hudShow (message: String? = nil) {
        currentHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        currentHud?.mode = .indeterminate
        
        if message != nil {
            currentHud?.label.text = message!
        }
    }
    
    fileprivate func hudDismiss() {
        currentHud?.hide(animated: true)
        currentHud = nil
    }
    
    @IBAction func getPhrase(_ sender: Any) {
        
        // Get a random quote
        let lower = 0
        let upper = phrases.count
        let number = arc4random_uniform(UInt32(upper - lower)) + UInt32(lower)
        
        textView.text = phrases[Int(number)].phrase
    }
}
