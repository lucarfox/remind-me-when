//
//  TimeDetailsView.swift
//  rmw
//
//  Created by Lucy Fox on 7/25/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit
import Foundation
import EventKit

class TimeDetailsView: UIView {
    
    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    let textBlue = UIColor(colorLiteralRed: 44.0/255.0, green: 123.0/255.0, blue: 214.0/255.0, alpha: 1.0)
    let green = UIColor(colorLiteralRed: 79.0/255.0, green: 210.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    
    fileprivate var datePicker : UIDatePicker = UIDatePicker()
    var doneButton: UIButton!
    var date : Date!
    var alarm : EKAlarm!
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.backgroundColor = backgroundBlue
        datePicker.frame = CGRect(x: 10.0, y: 70.0, width: 530, height: 600)
        datePicker.minuteInterval = 5
        datePicker.layer.cornerRadius = 5.0
        datePicker.clipsToBounds = true
        
        
        // Ciel current time by 5 min intervals and advance by 1 hour
        let calendar = Calendar.current
        datePicker.timeZone = calendar.timeZone
        let date1 = Date()
        let minutes = calendar.component(.minute, from: date1)
        let newMinutes = Int(ceil((Double(minutes) / 5.0)) * 5.0)
        var components = DateComponents()
        components.year = calendar.component(.year, from: date1)
        components.month = calendar.component(.month, from: date1)
        components.day = calendar.component(.day, from: date1)
        components.hour = calendar.component(.hour, from: date1) + 1
        components.minute = newMinutes
        let newDate = calendar.date(from: components)
        datePicker.setDate(newDate!, animated: true)
        setReminderDate(datePicker)
        
        datePicker.backgroundColor = UIColor.white
        datePicker.setValue(textBlue, forKeyPath: "textColor")
  
        datePicker.addTarget(self, action: #selector(setReminderDate(_:)), for: .valueChanged)
        self.addSubview(datePicker)
        datePicker.pinTop(v: self, o: 30)
        datePicker.pinCenter(v: self)
        setReminderDate(datePicker)
        
    }
    
    func setReminderDate(_ sender: UIDatePicker){
       // self.date = sender.date
        self.alarm = EKAlarm(absoluteDate: sender.date)
    }
    
    
    func configureDoneButton(){
        doneButton.imageView?.height(h: 25)
        doneButton.imageView?.width(w: 25)
        doneButton.height(h: 50)
        doneButton.width(w: 50)
        doneButton.layer.cornerRadius = 25
        doneButton.layer.masksToBounds = true
        doneButton.backgroundColor = green
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = green.cgColor
        self.addSubview(doneButton)
        doneButton.pinCenter(v: self)
        doneButton.pinTop2Bottom(v: datePicker, o: -25)
    }
    
}
