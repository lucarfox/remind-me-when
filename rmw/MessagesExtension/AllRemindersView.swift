//
//  AllRemindersView.swift
//  rmwRefactoring
//
//  Created by Tahia Emran on 7/30/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit

class AllRemindersView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var remindersCollectionView: UICollectionView!
    var reminders: [String]!
    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    
    convenience init(reminderNames: [String]){
        self.init(frame: CGRect.zero)
        self.backgroundColor = backgroundBlue
        self.reminders = reminderNames
        createCollectionView()
    }
    
    func createCollectionView(){
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 200, height: 40)
        self.remindersCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.remindersCollectionView.dataSource = self
        self.remindersCollectionView.delegate = self
        self.remindersCollectionView.register(ReminderCell.self, forCellWithReuseIdentifier: "reminderCell")
        self.addSubview(self.remindersCollectionView)
        self.remindersCollectionView.width(w: 300)
        self.remindersCollectionView.height(h: 600)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reminders.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.remindersCollectionView.dequeueReusableCell(withReuseIdentifier: "reminderCell", for: indexPath as! IndexPath) as! ReminderCell
        
        let reminderName = reminders[indexPath.item]
        cell.index = indexPath.item
        cell.delegate = self as! RemindersDelegate
        // cell.showSelect()
        
        cell.backgroundColor = UIColor.white
        let borderColor: CGColor = UIColor(colorLiteralRed: 135.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0).cgColor
        cell.layer.borderWidth = 1
        cell.layer.borderColor = borderColor
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 480, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    

}

extension AllRemindersView: RemindersDelegate{
    func selectedReminder(index: Int) {
        print ("hi")
    }
}
