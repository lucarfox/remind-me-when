//
//  ReminderCell.swift
//  rmwRefactoring
//
//  Created by Tahia Emran on 7/30/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit

protocol RemindersDelegate{
    func selectedReminder(index: Int)
}



class ReminderCell: UICollectionViewCell {
    
    fileprivate var label:UILabel?
    var index:Int!
    var delegate:RemindersDelegate?
    
    let selectButton = UIButton()
    //  let unFilledInSelect = #imageLiteral(resourceName: "success")
    let unselectButton = UIButton()
    //    let filledInSelect = #imageLiteral(resourceName: "success-2")
    
    fileprivate func addButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.delegate?.selectedReminder(index: self.index)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label = .none
        self.delegate = .none
        self.contentView.subviews.forEach({$0.removeFromSuperview()})
    }
    
    func showSelect() {
        //            self.selectButton.setImage(unFilledInSelect, for: .normal)
        //            self.selectButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        //            self.unselectButton.setImage(filledInSelect, for: .normal)
        //            self.unselectButton.addTarget(self, action: #selector(unselect), for: .touchUpInside)
        self.contentView.addSubview(unselectButton)
        self.contentView.addSubview(selectButton)
        selectButton.pinLeft(v: self, o: 69)
        selectButton.pinTop(v: self, o: 12)
        selectButton.height(h: 30)
        selectButton.width(w: 30)
        unselectButton.pinLeft(v: self, o: 69)
        unselectButton.pinTop(v: self, o: 12)
    }
    
}
