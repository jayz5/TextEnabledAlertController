//
//  ViewController.swift
//  TextEnabledAlertController
//
//  Created by Jay Zahn on 8/9/17.
//  Copyright © 2017 JayZahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        let alert = TextEnabledAlertController(title: "Enter Your Information", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            guard let textFields = alert.textFields,
                textFields.count >= 2 else { return }
            
            guard let name = textFields[0].text?.trimmingCharacters(in: .whitespaces) else { return }
            var text = "Hello \(name)!"
            if let food = textFields[1].text {
                text += "\n\nI love \(food) too!"
            }
            
            self.label.text = text
        }
        saveAction.isEnabled = false
        alert.addAction(saveAction)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Your name"
            textField.autocapitalizationType = .words
        }) { (textField) in
            saveAction.isEnabled = (textField.text?.characters.count ?? 0) > 0
        }
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Your favorite food"
        }, textChangeAction: nil)
        
        self.present(alert, animated: true, completion: nil)
    }

}

