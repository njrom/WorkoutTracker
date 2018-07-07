//
//  WorkoutBuilderViewController.swift
//  WorkoutTracker
//
//  Created by Nicholas Romano on 7/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit
import CoreData

class SessionBuilderViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var workoutCollectionView: UICollectionView!
    
    @IBOutlet weak var sessionNameLabel: UILabel!
    
    var currentSession : Session!
    var workouts = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Session Information
        currentSession = templateSessions.last
        sessionNameLabel.text = currentSession.name
        
        // Do any additional setup after loading the view.
        workoutCollectionView.delegate = self
        workoutCollectionView.dataSource = self
        
        // Set up layout
        let layout = workoutCollectionView.collectionViewLayout as! WorkoutCollectionViewLayout
        layout.delegate = self
        
        
    }

    
    @IBAction func addWorkoutPressed(_ sender: UIButton) { // Adds a workout to the list
        // Need to create a new workout , set workoutBuilders currentWorkout to that, then segue
        // Add Workout to collection Viewvar textField = UITextField()
        let alert = UIAlertController(title: "Add a new Workout", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add Workout", style: .default) { (action) in
            //What will happen when the user clicks the add item button on alert
            let newWorkout = Workout(context: self.context)
            newWorkout.name = textField.text!
            self.workouts.append(newWorkout)
            self.workoutCollectionView.reloadData()
            self.workoutCollectionView.collectionViewLayout.invalidateLayout()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Workout Name"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(workouts.count)
        return workouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = workoutCollectionView.dequeueReusableCell(withReuseIdentifier: "workoutCell", for: indexPath) as! WorkoutCollectionViewCell
        cell.titleLabel.text = workouts[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = workoutCollectionView.cellForItem(at: indexPath) as! WorkoutCollectionViewCell
        expand(workoutCell: cell)
    }
    
    func expand(workoutCell: WorkoutCollectionViewCell) {
        workoutCell.superview?.bringSubview(toFront: workoutCell)
        let x = workoutCell.frame.origin.x
        let y = workoutCell.frame.origin.y
        if(!workoutCell.expanded){
            
            let rect = CGRect(x: x, y: y, width: (workoutCell.frame.width), height: ((workoutCell.frame.height)*2))
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
                workoutCell.frame = rect
                workoutCell.expanded = true
            })
        } else {
            let rect = CGRect(x: x, y: y, width: (workoutCell.frame.width), height: ((workoutCell.frame.height)*0.5))
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
                workoutCell.frame = rect
                workoutCell.expanded = false
            })
        }
    }
    
    //TODO: Should Save TemplateArray on exit of view controller (we added a new template)

}


extension SessionBuilderViewController: WorkoutCollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}
