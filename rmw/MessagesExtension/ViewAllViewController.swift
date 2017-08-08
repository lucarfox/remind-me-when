//
//  ViewAllViewController.swift
//  rmwRefactoring
//
//  Created by Tahia on 7/27/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit
import Messages
import EventKit 

class ViewAllViewController: MSMessagesAppViewController {
    
    var viewAll: AllRemindersView!
    var eventStore : EKEventStore!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // isolate calendar
        let events = self.eventStore.calendars(for: EKEntityType.reminder)
        var correctCalendar = self.eventStore.defaultCalendarForNewReminders()
        for cal in events{
            if cal.title == "Message Reminders"{
                correctCalendar = cal
        }
        }
        
        // get all reminders 
        let predicate = self.eventStore.predicateForReminders(in: nil)
        self.eventStore.fetchReminders(matching: predicate, completion:  {(reminds: [EKReminder]?) -> Void in
            let reminderTitles : [String] = reminds!.map({($0 as! EKReminder) .title})
            self.viewAll = AllRemindersView(reminderNames: reminderTitles)
            
            self.requestPresentationStyle(.expanded)
            
            
            self.view.addSubview(self.viewAll)
            
            self.viewAll.pinX(v: self.view)
            self.viewAll.pinY(v: self.view)
            self.viewAll.pinAll(v: self.view) })
  
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
