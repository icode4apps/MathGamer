//
//  SumViewController.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 23/10/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

var performance = performances()

class SumViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var firstNumber: UILabel!
    @IBOutlet var secondNumber: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var calcButton: UIButton!
    @IBOutlet var myNumberTextField: UITextField!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var sumCounterLabel: UILabel!
    @IBOutlet var goButton: UIButton!
    @IBOutlet var marsButton: UIButton!
    @IBOutlet var score: UILabel!
    @IBOutlet var missionCompletedTime: UILabel!
    @IBOutlet var abortButton: UIButton!
    
    var firstNum: (Int) = 0
    var secondNum: (Int) = 0
    var sum: (Int) = 0
    var timer = NSTimer()
    var count = 0
    var timeFormat = String()
    var sumCounter = 0
    var timeFinal = 0
    var performances = Array<String>()
    let dateNow = NSDate()
    let formatter = NSDateFormatter()
    var dateFinal = String()
    let userDefaults = NSUserDefaults.standardUserDefaults()

    var audioPlayer: AVAudioPlayer!

    
    //Below is the function to update the arrays for the performances in each mission.

    func updateArrays() {
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("missionName")  != nil) {
            
            performance.missionNames = (self.userDefaults.objectForKey("missionName") as! [String])
            performance.time = (self.userDefaults.objectForKey("time") as! [String])
            performance.scoreArr = (self.userDefaults.valueForKey("score") as! [Int])
            performance.dates = (self.userDefaults.objectForKey("date") as! [String])
        }

        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.stringFromDate(dateNow)
        dateFinal = formatter.stringFromDate(dateNow)
        
        performance.missionNames.append("Earth")
        performance.time.append(score.text!)
        performance.scoreArr.append(sumCounter)
        performance.dates.append(dateFinal)
        
        self.userDefaults.setObject(performance.missionNames, forKey: "missionName")
        self.userDefaults.setObject(performance.time, forKey: "time")
        self.userDefaults.setValue(performance.scoreArr, forKey: "score")
        self.userDefaults.setObject(performance.dates, forKey: "date")
        self.userDefaults.synchronize()
        
    }
    
    //Updating time on screen.
    func updateTime() {
        
        timeFormat = String(format:"%02d:%02d:%02d", (count/6000)%100, (count/100)%60, count%100)
        count++
        timerLabel.text = timeFormat
        
        if count == 4001 && sumCounter < 200 {
            
            timer.invalidate()
            goButton.enabled = false
            calcButton.enabled = false
            
            let uiAlert = UIAlertController(title: "Sorry!", message: "Time is over! Minimum score to advance is 200. Start again! I know you can do it!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            startButton.enabled = true
            count = 0
            myNumberTextField.text = ""
    
            }
        
        //Checking if user was able to provide correct sum results within time limit.
        if count == 4001 && sumCounter >= 200 {
            
            timer.invalidate()
            goButton.enabled = false
            calcButton.enabled = false
            myNumberTextField.resignFirstResponder()
            myNumberTextField.enabled = false
            
            let uiAlert = UIAlertController(title: "Mission 1 Completed!", message: "Congratulations!! Now you can go to Mission 2: MARS! Good luck!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            marsButton.hidden = false
            
            updateArrays()
            
        }
    }
    
    //Starting the mission.
    @IBAction func startButton(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        startButton.enabled = false
        calcButton.enabled = true
        firstNum = Int(arc4random_uniform(6))
        secondNum = Int(arc4random_uniform(6))
        firstNumber.text = "\(firstNum)"
        secondNumber.text = "\(secondNum)"
        sumCounterLabel.text = "0"
        sumCounter = 0
        
    }
    
    //Go to next mission.
    
    @IBAction func goButton(sender: AnyObject) {
        
        firstNumber.enabled = true
        secondNumber.enabled = true
        firstNum = Int(arc4random_uniform(6))
        secondNum = Int(arc4random_uniform(6))
        firstNumber.text = "\(firstNum)"
        secondNumber.text = "\(secondNum)"
        calcButton.enabled = true
        goButton.enabled = false
        
    }
    
    @IBAction func calcButton(sender: AnyObject) {
        
        //Guaranteing that if user clicks when UITextField is empty it does not generates error of nil.
        if myNumberTextField.text == "" {
            
            let uiAlert = UIAlertController(title: "Oops!", message: "Please, enter a number!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
        }
        else {
        
        //Checking sum result.
        sum = firstNum + secondNum + Int(myNumberTextField.text!)!
        goButton.enabled = true
            
        if sum == 10 {
            
            sumCounter = sumCounter + 10
            calcButton.enabled = false
            myNumberTextField.text = ""
            sumCounterLabel.text = "\(sumCounter)"
            
            if sumCounter == 200 {
            
                timeFinal = count
                missionCompletedTime.hidden = false
                score.hidden = false
                score.text = timeFormat
            
                let soundURL: NSURL = NSBundle.mainBundle().URLForResource("goal", withExtension: "mp3")!
                audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL)
                audioPlayer.delegate = self
                audioPlayer.play()
                
                }
            
        else {
            
            myNumberTextField.text = ""
            calcButton.enabled = false
            firstNumber.enabled = false
            secondNumber.enabled = false
    
        }
        
    }
            myNumberTextField.text = ""
            calcButton.enabled = false
            firstNumber.enabled = false
            secondNumber.enabled = false
            
    }
        
    }
    
    @IBAction func marsButton(sender: AnyObject) {
        
        if audioPlayer.playing == true {
            audioPlayer.stop()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
            myNumberTextField.becomeFirstResponder()
            calcButton.enabled = false
            goButton.enabled = false
            startButton.layer.cornerRadius = 32
            goButton.layer.cornerRadius = 5
            calcButton.layer.cornerRadius = 5
            marsButton.layer.cornerRadius = 45
            marsButton.backgroundColor = UIColor.clearColor()
            marsButton.layer.borderWidth = 0.8
            marsButton.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7).CGColor
            marsButton.hidden = true
            missionCompletedTime.hidden = true
            score.hidden = true
            abortButton.layer.cornerRadius = 5
        
    }
    
    @IBAction func abortButton(sender: AnyObject) {
        
        timer.invalidate()
        
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
