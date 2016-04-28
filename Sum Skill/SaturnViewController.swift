//
//  SaturnViewController.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 06/11/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import AVFoundation

class SaturnViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var firstNumberSaturn: UILabel!
    @IBOutlet var yourNumberSaturn: UITextField!
    @IBOutlet var startButtonSaturn: UIButton!
    @IBOutlet var goButtonSaturn: UIButton!
    @IBOutlet var calcButtonSaturn: UIButton!
    @IBOutlet var timerSaturn: UILabel!
    @IBOutlet var scoreSaturn: UILabel!
    @IBOutlet var missionCompletionTimeSaturnTitle: UILabel!
    @IBOutlet var missionCompletionTimeSaturnLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var abortButton: UIButton!
    
    var sumSaturn = 0
    var firstNOSaturn = 0
    var timeSaturn = NSTimer()
    var countSaturn = 0
    var timeFormatSaturn = String()
    var sumCounterSaturn = 0
    var timeFinalSaturn = 0
    var performances = Array<String>()
    let dateNow = NSDate()
    let formatter = NSDateFormatter()
    var dateFinal = String()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var audioPlayer = AVAudioPlayer()
    
    func updateArrays() {
        
        performance.missionNames = self.userDefaults.objectForKey("missionName") as! [String]
        performance.time = self.userDefaults.objectForKey("time") as! [String]
        performance.scoreArr = self.userDefaults.valueForKey("score") as! [Int]
        performance.dates = self.userDefaults.objectForKey("date") as! [String]
        
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.stringFromDate(dateNow)
        dateFinal = formatter.stringFromDate(dateNow)
        
        performance.missionNames.append("Saturn")
        performance.time.append(missionCompletionTimeSaturnLabel.text!)
        performance.scoreArr.append(sumCounterSaturn)
        performance.dates.append(dateFinal)
        
        
        self.userDefaults.setObject(performance.missionNames, forKey: "missionName")
        self.userDefaults.setObject(performance.time, forKey: "time")
        self.userDefaults.setValue(performance.scoreArr, forKey: "score")
        self.userDefaults.setObject(performance.dates, forKey: "date")
        self.userDefaults.synchronize()
        
    }

    func updateTime() {
        
        
        timeFormatSaturn = String(format:"%02d:%02d:%02d", (countSaturn/6000)%100, (countSaturn/100)%60, countSaturn%100)
        
        countSaturn++
        timerSaturn.text = timeFormatSaturn
        
        if countSaturn == 4001 && sumCounterSaturn < 320 {
            
            timeSaturn.invalidate()
            goButtonSaturn.enabled = false
            calcButtonSaturn.enabled = false
            
            let uiAlert = UIAlertController(title: "Sorry!", message: "Time is over! Minimum score to succeed is 320. Restart in Mission 1!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            yourNumberSaturn.enabled = false
            restartButton.hidden = false
            
        }
        if countSaturn == 4001 && sumCounterSaturn >= 320 {
            
            timeSaturn.invalidate()
            goButtonSaturn.enabled = false
            calcButtonSaturn.enabled = false
            yourNumberSaturn.resignFirstResponder()
            yourNumberSaturn.enabled = false
            
            let uiAlert = UIAlertController(title: "Mission 4 Completed!", message: "Congratulations!! You completed all the 4 missions! But keep alert, more missions will come soon! Good bye!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            updateArrays()
            
            restartButton.hidden = false
        }
    }

    
    @IBAction func startButtonSaturn(sender: AnyObject) {
        
        timeSaturn = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
        startButtonSaturn.enabled = false
        calcButtonSaturn.enabled = true
        
        firstNOSaturn = Int(arc4random_uniform(1001))
        
        firstNumberSaturn.text = "\(firstNOSaturn)"
        
        scoreSaturn.text = "0"
        sumCounterSaturn = 0
        
    }
    
    @IBAction func goButtonSaturn(sender: AnyObject) {
        
        firstNumberSaturn.enabled = true
        
        firstNOSaturn = Int(arc4random_uniform(1001))
        
        firstNumberSaturn.text = "\(firstNOSaturn)"
        
        calcButtonSaturn.enabled = true
        goButtonSaturn.enabled = false
        
    }
    
    @IBAction func calcButtonSaturn(sender: AnyObject) {
        
        
        if yourNumberSaturn.text == "" {
            
            let uiAlert = UIAlertController(title: "Oops!", message: "Please, enter a number!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
        }
        else {
            
            sumSaturn = firstNOSaturn + Int(yourNumberSaturn.text!)!
            goButtonSaturn.enabled = true
            
            if sumSaturn == 1000 {
                
                sumCounterSaturn = sumCounterSaturn + 40
                calcButtonSaturn.enabled = false
                yourNumberSaturn.text = ""
                scoreSaturn.text = "\(sumCounterSaturn)"
                
                if sumCounterSaturn == 320 {
                    
                    timeFinalSaturn = countSaturn
                    missionCompletionTimeSaturnTitle.hidden = false
                    missionCompletionTimeSaturnLabel.hidden = false
                    missionCompletionTimeSaturnLabel.text = timeFormatSaturn
                    
                    let soundURL: NSURL = NSBundle.mainBundle().URLForResource("goal", withExtension: "mp3")!
                    audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL)
                    audioPlayer.delegate = self
                    audioPlayer.play()
                    
                }
                    
                else {
                    
                    yourNumberSaturn.text = ""
                    calcButtonSaturn.enabled = false
                    firstNumberSaturn.enabled = false
                    
                }
            }
            
            yourNumberSaturn.text = ""
            calcButtonSaturn.enabled = false
            firstNumberSaturn.enabled = false
            
        }

    }

    @IBAction func restartButton(sender: AnyObject) {
        
        }
    
    @IBAction func abortButton(sender: AnyObject) {
        timeSaturn.invalidate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yourNumberSaturn.becomeFirstResponder()
        
        calcButtonSaturn.enabled = false
        goButtonSaturn.enabled = false
        restartButton.hidden = true
        
        startButtonSaturn.layer.cornerRadius = 32
        goButtonSaturn.layer.cornerRadius = 5
        calcButtonSaturn.layer.cornerRadius = 5
        restartButton.layer.cornerRadius = 45
        restartButton.backgroundColor = UIColor.clearColor()
        restartButton.layer.borderWidth = 0.8
        restartButton.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7).CGColor
        
        missionCompletionTimeSaturnTitle.hidden = true
        missionCompletionTimeSaturnLabel.hidden = true
        abortButton.layer.cornerRadius = 5
        
        performance.missionNames = self.userDefaults.objectForKey("missionName") as! [String]
        performance.time = self.userDefaults.objectForKey("time") as! [String]
        performance.scoreArr = self.userDefaults.valueForKey("score") as! [Int]
        performance.dates = self.userDefaults.objectForKey("date") as! [String]
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }


}
