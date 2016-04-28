//
//  PerformanceTableViewCell.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 13/11/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit

class PerformanceTableViewCell: UITableViewCell {
    
    @IBOutlet var missionName: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
