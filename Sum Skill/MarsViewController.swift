//
//  MarsViewController.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 29/10/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import AVFoundation

import Foundation

class MarsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var firstNumberMars: UILabel!
    @IBOutlet var secondNumberMars: UILabel!
    @IBOutlet var timerLabelMars: UILabel!
    @IBOutlet var scoreLabelMars: UILabel!
    @IBOutlet var yourNumberMars: UITextField!
    @IBOutlet var startButtonMars: UIButton!
    @IBOutlet var goButtonMars: UIButton!
    @IBOutlet var calcButtonMars: UIButton!
    @IBOutlet var randomSumMars: UILabel!
    @IBOutlet var jupiterButton: UIButton!
    @IBOutlet var missionMarsCompletedTime: UILabel!
    @IBOutlet var missionMarsCompletedTimeLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var abortButton: UIButton!
    
    
    var sumMars = 0
    var firstNOMars = 0
    var secondNOMars = 0
    var timerMars = NSTimer()
    var countMars = 0
    var timeFormatMars = String()
    var sumCounterMars = 0
    var mySumMars = 0
    var timeFinalMars = 0
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
        
        performance.missionNames.append("Mars")
        performance.time.append(missionMarsCompletedTime.text!)
        performance.scoreArr.append(sumCounterMars)
        performance.dates.append(dateFinal)
        
        
        self.userDefaults.setObject(performance.missionNames, forKey: "missionName")
        self.userDefaults.setObject(performance.time, forKey: "time")
        self.userDefaults.setValue(performance.scoreArr, forKey: "score")
        self.userDefaults.setObject(performance.dates, forKey: "date")
        self.userDefaults.synchronize()
        
    }

    func updateTime() {
        
        
        timeFormatMars = String(format:"%02d:%02d:%02d", (countMars/6000)%100, (countMars/100)%60, countMars%100)
        
        countMars++
        timerLabelMars.text = timeFormatMars
        
        if countMars == 4001 && sumCounterMars < 220 {
            
            yourNumberMars.resignFirstResponder()
            timerMars.invalidate()
            goButtonMars.enabled = false
            calcButtonMars.enabled = false
            
            let uiAlert = UIAlertController(title: "Sorry!", message: "Time is over! Minimum score to proceed is 220. Restart in Mission 1!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            yourNumberMars.enabled = false
            restartButton.hidden = false
        }
        
        if countMars == 4001 && sumCounterMars >= 220 {
            
            timerMars.invalidate()
            goButtonMars.enabled = false
            calcButtonMars.enabled = false
            yourNumberMars.resignFirstResponder()
            yourNumberMars.enabled = false
            
            let uiAlert = UIAlertController(title: "Mission 2 Completed!", message: "Congratulations!! Now you can go to Mission 3: JUPITER! Good luck!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
        
            jupiterButton.hidden = false
            
            updateArrays()
        }
    }

    
    @IBAction func startButtonMars(sender: AnyObject) {
        
        timerMars = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
        startButtonMars.enabled = false
        calcButtonMars.enabled = true
        
        firstNOMars = Int(arc4random_uniform(11))
        secondNOMars = Int(arc4random_uniform(11))
        sumMars = Int(arc4random_uniform(41))
        
        repeat {
            sumMars = Int(arc4random_uniform(41))
        } while sumMars < 20
        
        firstNumberMars.text = "\(firstNOMars)"
        secondNumberMars.text = "\(secondNOMars)"
        randomSumMars.text = "\(sumMars)"
        
        scoreLabelMars.text = "0"
        sumCounterMars = 0
        
    }
    
    
    @IBAction func goButtonMars(sender: AnyObject) {
        
        firstNumberMars.enabled = true
        secondNumberMars.enabled = true
        randomSumMars.enabled = true
        
        firstNOMars = Int(arc4random_uniform(11))
        secondNOMars = Int(arc4random_uniform(11))
        sumMars = Int(arc4random_uniform(41))
        
        repeat {
            sumMars = Int(arc4random_uniform(41))
        } while sumMars < 20
        
        firstNumberMars.text = "\(firstNOMars)"
        secondNumberMars.text = "\(secondNOMars)"
        randomSumMars.text = "\(sumMars)"
        
        calcButtonMars.enabled = true
        goButtonMars.enabled = false
    }
    
    
    @IBAction func calcButtonMars(sender: AnyObject) {
        
        if yourNumberMars.text == "" {
            
            let uiAlert = UIAlertController(title: "Oops!", message: "Please, enter a number!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
        }
        else {
        
            mySumMars = firstNOMars + secondNOMars + Int(yourNumberMars.text!)!
            goButtonMars.enabled = true
            
            if mySumMars == sumMars {
                
                sumCounterMars = sumCounterMars + 20
                calcButtonMars.enabled = false
                yourNumberMars.text = ""
                scoreLabelMars.text = "\(sumCounterMars)"
                
                if sumCounterMars == 220 {
                    
                    timeFinalMars = countMars
                    missionMarsCompletedTime.hidden = false
                    missionMarsCompletedTimeLabel.hidden = false
                    missionMarsCompletedTime.text = timeFormatMars
                    
                    let soundURL: NSURL = NSBundle.mainBundle().URLForResource("goal", withExtension: "mp3")!
                    audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL)
                    audioPlayer.delegate = self
                    audioPlayer.play()
                    
                }
                
                else {
                    
                    yourNumberMars.text = ""
                    calcButtonMars.enabled = false
                    firstNumberMars.enabled = false
                    secondNumberMars.enabled = false
                    randomSumMars.enabled = false
                }
            }
            
            yourNumberMars.text = ""
            calcButtonMars.enabled = false
            firstNumberMars.enabled = false
            secondNumberMars.enabled = false
            randomSumMars.enabled = false
        
        }
        
    }
    
    @IBAction func jupiterButton(sender: AnyObject) {
        
        audioPlayer.stop()
    }
    
    @IBAction func restartButton(sender: AnyObject) {
        
    }
  
    @IBAction func abortButton(sender: AnyObject) {
        
        timerMars.invalidate()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourNumberMars.becomeFirstResponder()
        
        calcButtonMars.enabled = false
        goButtonMars.enabled = false

        startButtonMars.layer.cornerRadius = 32
        goButtonMars.layer.cornerRadius = 5
        calcButtonMars.layer.cornerRadius = 5
        jupiterButton.layer.cornerRadius = 45
        jupiterButton.backgroundColor = UIColor.clearColor()
        jupiterButton.layer.borderWidth = 0.8
        jupiterButton.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        restartButton.layer.cornerRadius = 45
        restartButton.backgroundColor = UIColor.clearColor()
        restartButton.layer.borderWidth = 0.8
        restartButton.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor

        jupiterButton.hidden = true
        restartButton.hidden = true
        
        missionMarsCompletedTime.hidden = true
        missionMarsCompletedTimeLabel.hidden = true
        
        abortButton.layer.cornerRadius = 5
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
