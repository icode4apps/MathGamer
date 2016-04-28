//
//  JupiterViewController.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 01/11/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import AVFoundation

class JupiterViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var firstNumberJupiter: UILabel!
    @IBOutlet var secondNumberJupiter: UILabel!
    @IBOutlet var yourNumberJupiter: UITextField!
    @IBOutlet var startButtonJupiter: UIButton!
    @IBOutlet var goButtonJupiter: UIButton!
    @IBOutlet var calcButtonJupiter: UIButton!
    @IBOutlet var timerJupiter: UILabel!
    @IBOutlet var scoreJupiter: UILabel!
    @IBOutlet var goToSaturn: UIButton!
    @IBOutlet var missionCompletionJupiter: UILabel!
    @IBOutlet var missionCompletionTimeJupiter: UILabel!
    @IBOutlet var saturnButton: UIButton!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var abortButton: UIButton!
    
    var sumJupiter = 0
    var firstNOJupiter = 0
    var secondNOJupiter = 0
    var timerNumberJupiter = NSTimer()
    var countJupiter = 0
    var timeFormatJupiter = String()
    var sumCounterJupiter = 0
    var mySumJupiter = 0
    var timeFinalJupiter = 0
    var resultSumJupiter = 0
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
        
        performance.missionNames.append("Jupiter")
        performance.time.append(missionCompletionTimeJupiter.text!)
        performance.scoreArr.append(sumCounterJupiter)
        performance.dates.append(dateFinal)
        
        self.userDefaults.setObject(performance.missionNames, forKey: "missionName")
        self.userDefaults.setObject(performance.time, forKey: "time")
        self.userDefaults.setValue(performance.scoreArr, forKey: "score")
        self.userDefaults.setObject(performance.dates, forKey: "date")
        self.userDefaults.synchronize()
        
    }

    
    func updateTime() {
        
        
        timeFormatJupiter = String(format:"%02d:%02d:%02d", (countJupiter/6000)%100, (countJupiter/100)%60, countJupiter%100)
        
        countJupiter++
        timerJupiter.text = timeFormatJupiter
        
        if countJupiter == 4001 && sumCounterJupiter < 270 {
            
            yourNumberJupiter.resignFirstResponder()
            timerNumberJupiter.invalidate()
            goButtonJupiter.enabled = false
            calcButtonJupiter.enabled = false
            
            let uiAlert = UIAlertController(title: "Sorry!", message: "Time is over! Minimum score to proceed is 270. Restart in Mission 1!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            yourNumberJupiter.enabled = false
            restartButton.hidden = false
            
        }
        
        if countJupiter == 4001 && sumCounterJupiter >= 270 {
            
            timerNumberJupiter.invalidate()
            goButtonJupiter.enabled = false
            calcButtonJupiter.enabled = false
            yourNumberJupiter.resignFirstResponder()
            yourNumberJupiter.enabled = false
            
            let uiAlert = UIAlertController(title: "Mission 3 Completed!", message: "Congratulations!! Now you can go to Mission 4: SATURN! Good luck!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
            
            goToSaturn.hidden = false
            updateArrays()
            
        }
    }
    
    @IBAction func startButtonJupiter(sender: AnyObject) {
        
        timerNumberJupiter = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
        startButtonJupiter.enabled = false
        calcButtonJupiter.enabled = true
        
        firstNOJupiter = Int(arc4random_uniform(10))
        secondNOJupiter = Int(arc4random_uniform(10))
        
        repeat {
            firstNOJupiter = Int(arc4random_uniform(10))
            secondNOJupiter = Int(arc4random_uniform(10))
        } while (firstNOJupiter * secondNOJupiter) < 1
        
        firstNumberJupiter.text = "\(firstNOJupiter)"
        secondNumberJupiter.text = "\(secondNOJupiter)"
        sumJupiter = firstNOJupiter * secondNOJupiter
        
        scoreJupiter.text = "0"
        sumCounterJupiter = 0
        
    }
    
    
    @IBAction func goButtonJupiter(sender: AnyObject) {
        
        firstNumberJupiter.enabled = true
        secondNumberJupiter.enabled = true
        
        firstNOJupiter = Int(arc4random_uniform(10))
        secondNOJupiter = Int(arc4random_uniform(10))
        
        repeat {
            firstNOJupiter = Int(arc4random_uniform(10))
            secondNOJupiter = Int(arc4random_uniform(10))
        } while (firstNOJupiter * secondNOJupiter) < 1
        
        firstNumberJupiter.text = "\(firstNOJupiter)"
        secondNumberJupiter.text = "\(secondNOJupiter)"
        sumJupiter = firstNOJupiter * secondNOJupiter
        
        calcButtonJupiter.enabled = true
        goButtonJupiter.enabled = false
        
    }
    
    
    @IBAction func calcButtonJupiter(sender: AnyObject) {
        
        if yourNumberJupiter.text == "" {
            
            let uiAlert = UIAlertController(title: "Oops!", message: "Please, enter a number!", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            }))
        }
        
        else {
            
            resultSumJupiter = 100 - (sumJupiter)
            mySumJupiter = Int(yourNumberJupiter.text!)!
            
            goButtonJupiter.enabled = true
            
            if mySumJupiter == resultSumJupiter {
                
                sumCounterJupiter = sumCounterJupiter + 30
                calcButtonJupiter.enabled = false
                yourNumberJupiter.text = ""
                scoreJupiter.text = "\(sumCounterJupiter)"
                
                if sumCounterJupiter == 270 {
                    
                    timeFinalJupiter = countJupiter
                    missionCompletionTimeJupiter.hidden = false
                    missionCompletionJupiter.hidden = false
                    missionCompletionTimeJupiter.text = timeFormatJupiter
                    
                    let soundURL: NSURL = NSBundle.mainBundle().URLForResource("goal", withExtension: "mp3")!
                    audioPlayer = try! AVAudioPlayer(contentsOfURL: soundURL)
                    audioPlayer.delegate = self
                    audioPlayer.play()
                }
                
                else {
                    
                    yourNumberJupiter.text = ""
                    calcButtonJupiter.enabled = false
                    firstNumberJupiter.enabled = false
                    secondNumberJupiter.enabled = false
                }
            }
            
            yourNumberJupiter.text = ""
            calcButtonJupiter.enabled = false
            firstNumberJupiter.enabled = false
            secondNumberJupiter.enabled = false
        }
    }
    
    @IBAction func saturnButton(sender: AnyObject) {
        
        if audioPlayer.playing == true {
            audioPlayer.stop()
        }
    }
    
    @IBAction func restartButton(sender: AnyObject) {
        

    }
    
    @IBAction func abortButton(sender: AnyObject) {
        timerNumberJupiter.invalidate()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourNumberJupiter.becomeFirstResponder()
        goToSaturn.hidden = true
        missionCompletionJupiter.hidden = true
        missionCompletionTimeJupiter.hidden = true
        goButtonJupiter.enabled = false
        calcButtonJupiter.enabled = false
        
        startButtonJupiter.layer.cornerRadius = 32
        goButtonJupiter.layer.cornerRadius = 5
        goToSaturn.layer.cornerRadius = 45
        goToSaturn.backgroundColor = UIColor.clearColor()
        goToSaturn.layer.borderWidth = 0.8
        goToSaturn.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        restartButton.layer.cornerRadius = 45
        restartButton.backgroundColor = UIColor.clearColor()
        restartButton.layer.borderWidth = 0.8
        restartButton.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).CGColor
        calcButtonJupiter.layer.cornerRadius = 5
        restartButton.hidden = true
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
