//
//  CompactContainerView.swift
//  rmwRefactoring
//
//  Created by Tahia on 7/27/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import UIKit

class CompactContainerView: UIView {

    let backgroundBlue = UIColor(colorLiteralRed: 88.0/255.0, green: 159.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    var name : String = ""
    var placeholderString: String = " "
    let startIndex = 12
    let nameStart = 18
    
    var defaultText: UITextField!

    convenience init(){
        self.init(frame: CGRect.zero)
        self.backgroundColor = backgroundBlue
        self.placeholderString = "Remind me to text" + name + " back when..."
        createDefaultTextField()
    }
    
    func createDefaultTextField(){
        
        self.defaultText = UITextField()
        self.defaultText.backgroundColor = UIColor.white
        self.defaultText.borderStyle = .roundedRect
        self.defaultText.layer.cornerRadius = 20
        self.defaultText.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.defaultText.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.defaultText.layer.shadowOpacity = 1.0
        self.defaultText.layer.shadowRadius = 0.0
        self.defaultText.layer.masksToBounds = false
        let namelength : Int = name.characters.count
        let mutableString : NSMutableAttributedString = NSMutableAttributedString(string: self.placeholderString)
        mutableString.addAttribute(NSForegroundColorAttributeName, value:backgroundBlue, range: NSRange(location: 0, length: placeholderString.characters.count))
        mutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 16.0), range: NSRange(location: 0, length: placeholderString.characters.count))
        let range1 = NSRange(location: startIndex, length: 6 + namelength + 5)
        mutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 16.0), range: range1)
        self.defaultText.attributedPlaceholder = mutableString

        self.addSubview(self.defaultText)
        self.defaultText.pinX(v:self)
        self.defaultText.pinLeftRight(v: self)
        self.defaultText.pinCenter(v: self)
        self.defaultText.height(h: 110)
        self.defaultText.textAlignment = .center
        
    
        
    }
    

}
