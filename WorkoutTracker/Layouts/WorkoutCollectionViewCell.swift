//
//  WorkoutCollectionViewCell.swift
//  WorkoutTracker
//
//  Created by Nicholas Romano on 7/4/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit

class WorkoutCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var expanded : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 14
        clipsToBounds = true
    }
}
