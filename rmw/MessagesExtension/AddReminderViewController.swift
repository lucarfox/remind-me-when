//
//  AddReminderViewController.swift
//  rmwRefactoring
//
//  Created by Tahia on 7/27/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit
import Messages
import EventKit
import MapKit


class AddReminderViewController: MSMessagesAppViewController {
    
    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    let green = UIColor(colorLiteralRed: 79.0/255.0, green: 210.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    let remindersTabTitle = "Message Reminders"
    

    var eventStore: EKEventStore!
    var timeDoneButton: UIButton!
    var locationDoneButton: UIButton!
    var createReminderView : ReminderDetailsView!
    var compactView: CompactContainerView!
    
    var reminder : EKReminder!
    var calendar : EKCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundBlue
        view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true

        
        reminder = EKReminder(eventStore: self.eventStore)
        self.calendar = self.eventStore.defaultCalendarForNewReminders()
        reminder.calendar = self.calendar
        
        initLocDoneButton()
        initTimeDoneButton()
        
        
        let mapView = MKMapView()
        self.createReminderView = ReminderDetailsView(map: mapView) // change the init!
        self.createReminderView.setLocationDoneButton(btn: self.locationDoneButton)
        self.createReminderView.setTimeDoneButton(btn: self.timeDoneButton)
      
        self.requestPresentationStyle(.expanded)
        self.view.addSubview(self.createReminderView)
        self.createReminderView.pinAll(v: self.view)
        
        self.compactView = CompactContainerView()
        
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
                if presentationStyle == .compact{
        
                    self.createReminderView.removeFromSuperview()
                    self.view.addSubview(self.compactView)
                    self.compactView.pinTopBottom(v: self.view, o: 100)
                    self.compactView.pinLeftRight(v: self.view, o: 75)
                }
        
                if presentationStyle == .expanded{
                    self.view.addSubview(self.createReminderView)
                    self.createReminderView.pinAll(v: self.view)
                }
    }


    fileprivate func initTimeDoneButton(){
        self.timeDoneButton = UIButton()
        self.timeDoneButton.backgroundColor = green
        self.timeDoneButton.setImage(#imageLiteral(resourceName: "verification-mark"), for: .normal)
        self.timeDoneButton.addTarget(self, action: #selector(createTimeReminder), for: .touchUpInside)
        
    }
    
    public func createTimeReminder(){
        self.reminder.title = self.createReminderView.reminderText
        
        var correctTab : EKCalendar = self.eventStore.defaultCalendarForNewReminders()
        for calendar in self.eventStore.calendars(for: EKEntityType.reminder){
            if calendar.title == "Message Reminders"{
                correctTab = calendar
        }
        }
        
        self.reminder.calendar = correctTab
        self.reminder.addAlarm(self.createReminderView.getTimeAlarm())
        do{
            try self.eventStore.save(self.reminder, commit: true)
            self.reminder = EKReminder()
            reminderCreated()
        }
        catch let err{
            print (err.localizedDescription)
        }
        
    }
    
    
    fileprivate func initLocDoneButton(){
        self.locationDoneButton = UIButton()
        self.locationDoneButton.backgroundColor = green
        self.locationDoneButton.setImage(#imageLiteral(resourceName: "verification-mark"), for: .normal)
        self.locationDoneButton.addTarget(self, action: #selector(createLocationReminder), for: .touchUpInside)
    }
    
    public func createLocationReminder(){
        self.reminder.title = self.createReminderView.reminderText
        var correctTab : EKCalendar = self.eventStore.defaultCalendarForNewReminders()
        for calendar in self.eventStore.calendars(for: EKEntityType.reminder){
            if calendar.title == "Message Reminders"{
                correctTab = calendar
            }
        }
        
        self.reminder.calendar = correctTab
        self.reminder.addAlarm(self.createReminderView.getLocationAlarm())
        do{
            try self.eventStore.save(self.reminder, commit: true)
            self.reminder = EKReminder()
            reminderCreated()
        }
        catch let err{
            print (err.localizedDescription)
        }

    }
    
    public func reminderCreated(){
        super.requestPresentationStyle(.compact)
        let messagesVc = MessagesViewController()
        messagesVc.isFirstRun = false
        messagesVc.eventStore = self.eventStore
        self.present(messagesVc, animated: false, completion: nil)
        
        
    }
  
}

