//
//  ViewController.swift
//  TIMER
//
//  Created by Vincent Bossaerts on 12/10/2018.
//  Copyright © 2018 Vincent Bossaerts. All rights reserved.
//

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}

import Cocoa

let False: Bool = false
let True: Bool = true


class TimerTime {
    
    var timeseconds: Int
    
    var seconds: String {
        get {
            if Int(self.timeseconds) < 10 {
                return "0"+String(timeseconds)
            }
            return String(timeseconds)
        }
        set (newValue) {
            if let newSeconds = Int(newValue) {
                if newSeconds < 60 {
                    self.timeseconds = newSeconds
                } else {
                    self.timeseconds = 0
                    self.minutes = String(Int(self.minutes)! + 1)
                }
            }
        }
    }
    
    var timeminutes: Int
    
    var minutes: String {
        get {
            if Int(self.timeminutes) < 10 {
                return "0"+String(timeminutes)
            }
            return String(timeminutes)
        }
        set (newValue) {
            if let newMinutes  = Int(newValue) {
                if newMinutes < 60 {
                    self.timeminutes = newMinutes
                } else {
                    self.timeminutes = 0
                    self.hours = String(Int(self.hours)! + 1)
                }
            }
        }
    }

    var timehours: Int
    
    var hours: String {
        get {
            if Int(self.timehours) < 10 {
                return "0"+String(timehours)
            }
            return String(timehours)
        }
        set (newValue) {
            if let newHours  = Int(newValue) {
                if newHours < 24 {
                    self.timehours = newHours
                } else {
                    self.timehours = 0
                    self.days = String(Int(self.days)! + 1)
                }
            }
        }
    }
    
    var timedays: Int
    
    var days: String {
        get {
            if Int(self.timedays) < 10 {
                return "0"+String(timedays)
            }
            return String(timedays)
        }
        set (newValue) {
            if let newDays  = Int(newValue) {
                self.timedays = newDays
            }
        }
    }
    
    init() {
        timeseconds = 0
        timeminutes = 0
        timehours = 0
        timedays = 0

    }
    
    func increment(by: Int)->String {
        self.seconds = String(Int(self.seconds)! + by)
        return self.getTime()
    }
    func getTime()->String {
        if self.timedays == 0 {
            return "\(self.hours):\(self.minutes):\(self.seconds)"
        }
        return "\(self.days):\(self.hours):\(self.minutes):\(self.seconds)"
    }
    
    func reset() {
        self.timeseconds = 0
        self.timeminutes = 0
        self.timehours = 0
        self.timedays = 0
    }
    
    
}

class ViewController: NSViewController {
    
    
    @IBOutlet weak var timeLAbel: NSTextField!
    
    var timer = Timer()
    
    @IBOutlet weak var pauseButtonOutlet: NSButton!
    
    var myTimer = TimerTime()
    
    var isRunning: Bool = false
    
    func scheduledTimerWithTimeInterval(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.SecondCallback), userInfo: nil, repeats: true)
        
        
    }
    @objc func SecondCallback() {
        if isRunning {
            let currentTime = myTimer.increment(by: 1)
            timeLAbel.stringValue = currentTime
        }
    }
    
    @IBAction func pausebutton(_ sender: Any) {
        if isRunning == true {
            isRunning = false
            timer.invalidate()
            pauseButtonOutlet.title = "RESUME"
        } else {
            isRunning = true
            scheduledTimerWithTimeInterval()
            pauseButtonOutlet.title = "PAUSE"
        }
    }
    @IBAction func startbutton(_ sender: Any) {
        timeLAbel.stringValue = "00:00:00"
        pauseButtonOutlet.title = "PAUSE"
        isRunning = true
        timer.invalidate()
        scheduledTimerWithTimeInterval()
    }
    
    @IBAction func stopbutton(_ sender: Any) {
        if isRunning == true {
            isRunning = false
        }
        myTimer.reset()
        timeLAbel.stringValue = "00:00:00"
        pauseButtonOutlet.title = "PAUSE"
        timer.invalidate()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()

        // Do any additional setup after loading the view.
    }
    /*
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    */
    


}

