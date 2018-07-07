//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Nicholas Romano on 7/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit

var templateSessions = [Session]() // Only adds to templateSessions to then have Session builder save it
//TODO: could probably have templateSessions sent to either SessionBuilder and Session selector 
class MenuViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    @IBAction func addTemplatePressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new Template", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Template", style: .default) { (action) in
            //What will happen when the user clicks the add item button on alert
            let newTemplate = Session(context : self.context)
            newTemplate.name = textField.text!
            templateSessions.append(newTemplate)
            self.performSegue(withIdentifier: "goToSessionBuilder", sender: self)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

