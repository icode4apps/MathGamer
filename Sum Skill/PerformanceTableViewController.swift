//
//  PerformanceTableViewController.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 13/11/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import Foundation

class PerformanceTableViewController: UITableViewController {
    
    var missionNames = [String]()
    var time = [String]()
    var scoreArr = [Int]()
    var dates = [String]()
    
    let userDefaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
            
        performance.missionNames = (self.userDefaults.objectForKey("missionName")) as! [String]
        performance.time = (self.userDefaults.objectForKey("time")) as! [String]
        performance.scoreArr = (self.userDefaults.valueForKey("score")) as! [Int]
        performance.dates = (self.userDefaults.objectForKey("date")) as! [String]
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return performance.missionNames.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PerformanceTableViewCell
    cell.missionName.text! = performance.missionNames[indexPath.row]
    cell.time.text! = performance.time[indexPath.row]
    cell.score.text! = String(performance.scoreArr[indexPath.row])
    cell.date.text! = performance.dates[indexPath.row]

    return cell
        
    }
   
  
    // Delete a cell.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
                
                performance.missionNames.removeAtIndex(indexPath.row)
                performance.time.removeAtIndex(indexPath.row)
                performance.scoreArr.removeAtIndex(indexPath.row)
                performance.dates.removeAtIndex(indexPath.row)
                
                self.tableView.reloadData()
                
                self.userDefaults.setObject(performance.missionNames, forKey: "missionName")
                self.userDefaults.setObject(performance.time, forKey: "time")
                self.userDefaults.setValue(performance.scoreArr, forKey: "score")
                self.userDefaults.setObject(performance.dates, forKey: "date")
                self.userDefaults.synchronize()
            
        }
        
    }



}