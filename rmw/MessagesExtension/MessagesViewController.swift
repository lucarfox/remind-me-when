//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Tahia on 7/27/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit
import Messages
import EventKit

class MessagesViewController: MSMessagesAppViewController {
    
    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    let green = UIColor(colorLiteralRed: 79.0/255.0, green: 210.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    let remindersTabTitle = "Message Reminders"
    
    fileprivate var introTextBox: CompactContainerView!
    fileprivate var addReminderButton : UIButton!
    fileprivate var viewAllButton : UIButton!
    
   
    var eventStore: EKEventStore = EKEventStore()
    var isFirstRun: Bool = true
    fileprivate var remindersCalendar: EKCalendar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestPresentationStyle(.compact)
        
        self.view.backgroundColor = backgroundBlue
        view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true

        self.eventStore.requestAccess(to: EKEntityType.reminder, completion:  ( { (granted: Bool, error: Error?) in
            if granted{
               self.configureRemindersTab()
            }}))
        
        
        self.introTextBox = CompactContainerView()
        
        
        initAddReminderButton()
        initViewAllRemindersButton()
        
        configureView()
        self.requestPresentationStyle(.compact)
        
        print(self.presentationStyle.rawValue);
        
    }
    
    
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        if presentationStyle == .expanded{
            let addVC = AddReminderViewController()
            addVC.eventStore = self.eventStore
            addVC.calendar = self.remindersCalendar
            self.present(addVC, animated: false, completion: nil)
        }
        
        if presentationStyle == .compact{
            configureView()
        }
    }
    
    
    fileprivate func initAddReminderButton(){
        self.addReminderButton = UIButton()
        self.addReminderButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        addReminderButton.addTarget(self, action: #selector(addReminderButtonPressed), for: .touchUpInside)
        addReminderButton.backgroundColor = green
        self.addReminderButton.layer.cornerRadius = 25
        self.addReminderButton.layer.borderWidth = 0
        self.addReminderButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.addReminderButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.addReminderButton.layer.shadowOpacity = 1.0
        self.addReminderButton.layer.shadowRadius = 0.0
        self.addReminderButton.layer.masksToBounds = false
    }
    
    public func addReminderButtonPressed(){
        self.requestPresentationStyle(.expanded)
        let addVC = AddReminderViewController()
        addVC.eventStore = self.eventStore
        addVC.calendar = self.remindersCalendar
        self.present(addVC, animated: false, completion: nil)
    }
    
    fileprivate func initViewAllRemindersButton(){
        self.viewAllButton = UIButton()
        self.viewAllButton.setImage(#imageLiteral(resourceName: "seeAll"), for: .normal)
        self.viewAllButton.addTarget(self, action: #selector(viewAllButtonPressed), for: .touchUpInside)
    }
    
    public func viewAllButtonPressed(){
        let viewVC = ViewAllViewController()
        self.present(viewVC, animated: false, completion: nil)
    }
    
    
    public func configureRemindersTab(){
        let calendars = self.eventStore.calendars(for: EKEntityType.reminder)
        var calFound : Bool = false
        for cal in calendars{
            if cal.title == remindersTabTitle{
                calFound = true
            }
        }
        
        if calFound == false{
            let newCalendar = EKCalendar(for: EKEntityType.reminder, eventStore: self.eventStore)
            newCalendar.title = remindersTabTitle
            newCalendar.source = self.eventStore.defaultCalendarForNewReminders().source
            
            do{
                try self.eventStore.saveCalendar(newCalendar, commit: true)
                self.remindersCalendar = newCalendar
            }
                
            catch let err{
                print (err.localizedDescription)
            }
        }
    }
    
    
    fileprivate func configureView(){
 
        self.view.addSubview(self.introTextBox)
        self.view.addSubview(self.addReminderButton)
        self.view.addSubview(self.viewAllButton)
        
        self.viewAllButton.pinTop(v: self.view, o: 15)
        self.viewAllButton.pinRight(v: self.view, o: -15)
        self.viewAllButton.width(w: 25)
        self.viewAllButton.height(h: 20)
        
        self.introTextBox.pinLeftRight(v: self.view, o: 30)
        self.introTextBox.pinX(v: self.view)
        self.introTextBox.pinTop(v: self.view, o: 25)
        self.introTextBox.pinBottom(v:self.view, o: -50)
        
        self.addReminderButton.pinBottom(v: self.introTextBox)
        self.addReminderButton.width(w: 50)
        self.addReminderButton.height(h: 50)
        self.addReminderButton.pinX(v: self.introTextBox, o: 5)
        self.addReminderButton.pinY(v: self.introTextBox, o: 50)
        
        if !isFirstRun{
            let successLabel = UILabel()
            successLabel.backgroundColor = green
            successLabel.text = "Reminder created successfully!"
            successLabel.textAlignment = .center
            successLabel.textColor = UIColor.white
            successLabel.layer.cornerRadius = 7
            successLabel.layer.masksToBounds = true
            self.view.addSubview(successLabel)
            
            successLabel.pinTop(v:self.introTextBox, o: 200)
            successLabel.pinX(v:self.introTextBox)
            successLabel.height(h: 30)
            successLabel.width(w: 350)
            self.introTextBox.defaultText.delegate = self
            

        }

        
    }
    
}
extension MessagesViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.requestPresentationStyle(.expanded)
        return true
    }
}


