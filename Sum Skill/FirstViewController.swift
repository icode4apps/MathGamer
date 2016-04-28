//
//  FirstViewController.swift
//  Sum Skill
//
//  Created by Joao Batista Rocha Jr. on 27/10/15.
//  Copyright © 2015 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class FirstViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var howToPlayButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var performancesButton: UIButton!
    @IBOutlet var sendCommentsButton: UIButton!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBAction func howToPlayButton(sender: AnyObject) {
        
    }
    
    
    @IBAction func playButton(sender: AnyObject) {
        
        
    }

    @IBAction func performancesButton(sender: AnyObject) {
        
        
    }
        
    @IBAction func sendCommentsButton(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["info@icodendesign.com"])
        mailComposerVC.setSubject("Feedback: MathGamer App")
        mailComposerVC.setMessageBody("Hi Joao...", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Oops!", message: "Looks like your device cannot send emails. No problem, just send me this email to info@icodendesign.com from your computer", preferredStyle: .Alert)
        sendMailErrorAlert.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("missionName")  != nil) {
            
            performance.missionNames = (self.userDefaults.objectForKey("missionName") as! [String])
            performance.time = (self.userDefaults.objectForKey("time") as! [String])
            performance.scoreArr = (self.userDefaults.valueForKey("score") as! [Int])
            performance.dates = (self.userDefaults.objectForKey("date") as! [String])
        }
        
        if performance.missionNames.count == 0 {
            performancesButton.enabled = false
        }
        else {
            performancesButton.enabled = true
        }
        
            howToPlayButton.layer.cornerRadius = 5
            playButton.layer.cornerRadius = 53
            performancesButton.layer.cornerRadius = 5
            sendCommentsButton.layer.cornerRadius = 5
            playButton.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
            playButton.layer.borderWidth = 0.7
            playButton.layer.borderColor = UIColor.grayColor().CGColor
        
        }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    }
    

