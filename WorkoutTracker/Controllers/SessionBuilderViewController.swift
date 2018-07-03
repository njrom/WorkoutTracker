//
//  WorkoutBuilderViewController.swift
//  WorkoutTracker
//
//  Created by Nicholas Romano on 7/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit
import CoreData

class SessionBuilderViewController: UIViewController {
    var currentSession = templateSessions.last
    var workouts = [Workout]()
    @IBOutlet weak var sessionNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionNameLabel.text = currentSession?.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    


}
