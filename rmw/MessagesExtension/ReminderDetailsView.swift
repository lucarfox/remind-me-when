//
//  ReminderDetailsViewController.swift
//  rmw
//
//  Created by Lucy Fox on 7/25/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit
import EventKit
import MapKit

// pink : ff6377
// green : 2dd67b

class ReminderDetailsView: UIView {
    
    var timeStackView: UIStackView!
    var locationStackView: UIStackView!
    var whiteLabel1: UILabel!
    var whiteLabel2: UILabel!
    
    var reminderTextField: UITextField!
    var reminderText : String!
    
    var timeView : TimeDetailsView!
    var placeView : LocationDetailsView!
    var mapView: MKMapView!
    
    var calendar : EKCalendar!
    var timeSwitch: UISwitch!
    var locationSwitch: UISwitch!
    
    var addLocReminderBtn : UIButton!
    var addTimeReminderBtn : UIButton!
    
    var name: String = ""
    var placeholderString : String = ""
    let startIndex = 12
    let nameStart = 18
    
    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    let textBlue = UIColor(colorLiteralRed: 44.0/255.0, green: 123.0/255.0, blue: 214.0/255.0, alpha: 1.0)
    
    convenience init(map: MKMapView){ // REQUIRE ADD BUTTON
        self.init(frame: CGRect.zero)
       
        self.backgroundColor = backgroundBlue
        self.mapView = map
        self.placeholderString = "Remind me to text" + name + " back when..."
        self.reminderText = "text back"
     
       
        initTextField()
        initTimeBar()
        initLocationBar()
        self.timeView = TimeDetailsView()
        self.placeView = LocationDetailsView(map: self.mapView)
        
        addTimeView()
        
    }
    
    fileprivate func initTextField(){
        self.reminderTextField = UITextField()
        self.reminderTextField.borderStyle = .none
        self.reminderTextField.textColor = UIColor.white
        self.reminderTextField.height(h: 50)
        self.reminderTextField.isUserInteractionEnabled = true
        self.reminderTextField.delegate = self
        setReminderTextPlaceholder()
        self.addSubview(self.reminderTextField)
        self.reminderTextField.pinTop(v: self, o: 125)
        self.reminderTextField.pinX(v: self)
        
    }
    
    fileprivate func setReminderTextPlaceholder(){
        let namelength : Int = name.characters.count
        let mutableString : NSMutableAttributedString = NSMutableAttributedString(string: self.placeholderString)
        mutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor.white, range: NSRange(location: 0, length: placeholderString.characters.count))
        mutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 16.0), range: NSRange(location: 0, length: placeholderString.characters.count))
        let range1 = NSRange(location: startIndex, length: 6 + namelength + 6)
        mutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 16.0), range: range1)
        
        self.reminderTextField.attributedPlaceholder = mutableString
        
    }
    
    
    
    fileprivate func initTimeBar(){
        self.whiteLabel1 = self.makeWhiteLabel()
        self.addSubview(self.whiteLabel1)
        self.whiteLabel1.pinX(v: self)
        self.whiteLabel1.pinTop2Bottom(v: self.reminderTextField, o: 20)
        
        let timeImage = #imageLiteral(resourceName: "blueTime")
        let timeImageView = UIImageView(image: timeImage)
        
        self.timeStackView = UIStackView()
        self.timeStackView.axis = .horizontal
        self.timeStackView.distribution = .fill
        self.timeStackView.height(h: 40)
        self.timeStackView.width(w: 300)
        self.timeStackView.addSubview(timeImageView)
        timeImageView.pinLeft(v: self.timeStackView)
        timeImageView.pinY(v: self.timeStackView)
        timeImageView.height(h: 25)
        timeImageView.width(w: 25)
        let timeLabel = UILabel()
        timeLabel.text = "At a time"
        timeLabel.textColor = self.textBlue
        self.timeStackView.addSubview(timeLabel)
        timeLabel.pinLeft2Right(v: timeImageView, o: 10)
        timeLabel.pinY(v: self.timeStackView)
        
        self.timeSwitch = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
        self.timeSwitch.isOn = true
        self.timeSwitch.setOn(true, animated: false);
        self.timeSwitch.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        self.timeStackView.addSubview(self.timeSwitch)
        self.timeSwitch.pinY(v: self.timeStackView)
        
        self.addSubview(self.timeStackView)
        self.timeStackView.width(w: 300)
        self.timeStackView.pinX(v: self)
        self.timeStackView.pinTop2Bottom(v: self.reminderTextField, o: 20)
        self.timeSwitch.pinRight(v: self.timeStackView)

    }
    
    
    
    fileprivate func initLocationBar(){
        self.whiteLabel2 = self.makeWhiteLabel()
        self.addSubview(self.whiteLabel2)
        self.whiteLabel2.pinX(v: self)
        self.whiteLabel2.pinTop2Bottom(v: self.whiteLabel1, o: 20)
        
        let locationImage = #imageLiteral(resourceName: "blueLocation")
        let locationImageView = UIImageView(image: locationImage)
        
        self.locationStackView = UIStackView()
        self.locationStackView.axis = .horizontal
        self.locationStackView.distribution = .fill
        self.locationStackView.height(h: 40)
        self.locationStackView.width(w: 300)
        self.locationStackView.addSubview(locationImageView)
        locationImageView.pinLeft(v: self.locationStackView)
        locationImageView.pinY(v: self.locationStackView)
        locationImageView.height(h: 25)
        locationImageView.width(w: 25)
        let locationLabel = UILabel()
        locationLabel.text = "At a place"
        locationLabel.textColor = self.textBlue
        self.locationStackView.addSubview(locationLabel)
        locationLabel.pinLeft2Right(v: locationImageView, o: 10)
        locationLabel.pinY(v: self.locationStackView)
        
        self.locationSwitch = UISwitch(frame: CGRect(x: 150, y: 300, width: 0, height: 0))
        self.locationSwitch.isOn = false
        self.locationSwitch.setOn(false, animated: false);
        self.locationSwitch.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        self.locationStackView.addSubview(self.locationSwitch)
        self.locationSwitch.pinY(v: self.locationStackView)
        
        self.addSubview(self.locationStackView)
        self.locationStackView.width(w: 300)
        self.locationStackView.pinX(v: self)
        self.locationStackView.pinTop2Bottom(v: self.whiteLabel1, o: 20)
        self.locationSwitch.pinRight(v: self.locationStackView)
    }
    
    
    func makeWhiteLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.width(w: 320)
        label.height(h: 40)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }
    
    func switchValueDidChange(sender:UISwitch!){
        if (sender == timeSwitch) {
            locationSwitch.isOn = !timeSwitch.isOn
            if (timeSwitch.isOn) {
                addTimeView()
            } else {
                addPlaceView()
            }
        } else if (sender == locationSwitch) {
            timeSwitch.isOn = !locationSwitch.isOn
            if (locationSwitch.isOn) {
                addPlaceView()
            } else {
                addTimeView()
            }
        } else {
            print("problem")
        }
    }


    func addTimeView() {
        if self.subviews.contains(self.placeView){
            self.placeView.removeFromSuperview()
        }
        
        self.addSubview(timeView)
        timeView.pinLeftRight(v: self)
        timeView.pinTop2Bottom(v: self.locationStackView)
        timeView.height(h: 500)
    }
    
    func addPlaceView() {
        timeView.removeFromSuperview()
        
        self.addSubview(placeView)
        placeView.pinLeftRight(v: self, o: 47)
        placeView.pinTop2Bottom(v: self.locationStackView, o: 5)
        placeView.height(h: 300)
    }
    
    
    public func getTimeAlarm() -> EKAlarm{
        return self.timeView.alarm
    }
    
    public func getLocationAlarm() -> EKAlarm{
        return self.placeView.alarm
    }
    
    public func setTimeDoneButton(btn: UIButton){
        self.timeView.doneButton = btn
        self.timeView.configureDoneButton()
    }
    
    public func setLocationDoneButton(btn: UIButton){
        self.placeView.doneButton = btn
        self.placeView.configureDoneButton()
    }
    
}

extension ReminderDetailsView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print ("hi")
        self.reminderText = self.reminderTextField.text!
        self.reminderTextField.resignFirstResponder()
        return true
    }
    
}
