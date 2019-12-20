//
//  ViewController.swift
//  Timer
//
//  Created by Fahim Rahman on 6/12/19.
//  Copyright © 2019 Fahim Rahman. All rights reserved.
//


//  Done with Auto-Layout. If you find any bug please inform me.


import UIKit

class ViewController: UIViewController {
    
    // Making the status bar elements lighter
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Timer Label Outlet
    @IBOutlet weak var timerLabel: UILabel!
    
    // Buttons Outlet (start,stop and reset)
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // Variables
    var gameTimer: Timer?

    var second: Int = 0
    var minute: Int = 0
    var hour: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Making the buttons round shape
        startButton.layer.cornerRadius = 35
        stopButton.layer.cornerRadius = 35
        resetButton.layer.cornerRadius = 35
        
        // Making the buttons enabled/disabled and setting alpha values
        startButton.isEnabled = true
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
    
        // Setting timer Label initial values
        timerLabel.text = "00:00:00"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        
        // Calling the custom function in every second
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        // Making the buttons enabled/disabled and setting alpha values
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        startButton.alpha = 0.5
        stopButton.alpha = 1
        
    }
    
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        
        // Invalidate the auto custom function
        gameTimer?.invalidate()
        
        // Making the buttons enabled/disabled and setting alpha values
        stopButton.isEnabled = false
        startButton.isEnabled = true
        
        stopButton.alpha = 0.5
        startButton.alpha = 1
        
        resetButton.isEnabled = true
        resetButton.alpha = 1
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        
        // Invalidate the auto custom function
        gameTimer?.invalidate()
        
        // Setting timer Label initial values
        timerLabel.text = "00:00:00"

        // variables are resetting to zero to reset the timer
        second = 0
        minute = 0
        hour = 0
        
        // Making the buttons enabled/disabled and setting alpha values
        startButton.isEnabled = true
        startButton.alpha = 1
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        resetButton.isEnabled = true
        resetButton.alpha = 1
    }
    
    // Custom function for the timing calcualtion
    @objc func runTimedCode() {
        
        second +=  1
        
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        if second > 59 {
            minute += 1
            second = 0
            secondString = "00"
            minuteString = "0\(minute)"
        }
        
        var hourString = "\(hour)"
        if hour < 10 {
            hourString = "0\(hour)"
        }
        if minute > 59 {
            hour += 1
            minute = 0
            minuteString = "00"
            hourString = "0\(hour)"
            
        }
        // Sending the values to the timer label
        timerLabel.text = "\(hourString):\(minuteString):\(secondString)"
    }
    
    @objc func appMovedToBackground() {
        gameTimer?.invalidate()
        startButton.isEnabled = true
        startButton.alpha = 1
    }
}

