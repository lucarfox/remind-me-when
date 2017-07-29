//
//  Constraints.swift
//  rmwRefactoring
//
//  Created by Tahia on 7/27/17.
//  Copyright © 2017 Tahia. All rights reserved.
//

import Foundation
//
//  Copyright © 2016 Microsoft. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // positive - create smaller
    // negative - create larger
    
    @discardableResult
    public func pinAll(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        
        return (pinTop(v: v, o: o, p: p), pinLeft(v: v, o: o, p: p), pinBottom(v: v, o: -o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinTopLeft(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinTop(v: v, o: o, p: p), pinLeft(v: v, o: o, p: p))
    }
    
    @discardableResult
    public func pinTopLeftBottom(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        return (pinTop(v: v, o: o, p: p), pinLeft(v: v, o: o, p: p), pinBottom(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinTopLeftRight(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        return (pinTop(v: v, o: o, p: p), pinLeft(v: v, o: o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinTopBottom(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinTop(v: v, o: o, p: p), pinBottom(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinTopBottomRight(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        return (pinTop(v: v, o: o, p: p), pinBottom(v: v, o: -o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinTopRight(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinTop(v: v, o: o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinLeftBottom(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinLeft(v: v, o: o, p: p), pinBottom(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinLeftBottomRight(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) {
        return (pinLeft(v: v, o: o, p: p), pinBottom(v: v, o: -o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinLeftRight(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinLeft(v: v, o: o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    @discardableResult
    public func pinBottomRight(v:UIView, o:CGFloat = 0.0, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinBottom(v: v, o: -o, p: p), pinRight(v: v, o: -o, p: p))
    }
    
    //MARK: size
    
    @discardableResult
    public func size(s:CGFloat, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (width(w: s, p: p), height(h: s, p: p))
    }
    
    @discardableResult
    public func size(w:CGFloat, h:CGFloat, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (width(w: w, p: p), height(h: h, p: p))
    }
    
    @discardableResult
    public func pinSize(v:UIView, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinWidth(v: v, p: p), pinHeight(v: v, p: p))
    }
    
    //MARK: width
    
    @discardableResult
    public func width(w:CGFloat, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.widthAnchor.constraint(equalToConstant: w)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinWidth(v:UIView, o:CGFloat = 0.0, m:CGFloat = 1.0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.widthAnchor.constraint(equalTo: v.widthAnchor, multiplier: m, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinWidth2Height(v:UIView, o:CGFloat = 0.0, m:CGFloat = 1.0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.widthAnchor.constraint(equalTo: v.heightAnchor, multiplier: m, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    //MARK: height
    
    @discardableResult
    public func height(h:CGFloat, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.heightAnchor.constraint(equalToConstant: h)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinHeight(v:UIView, o:CGFloat = 0.0, m:CGFloat = 1.0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.heightAnchor.constraint(equalTo: v.heightAnchor, multiplier: m, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinHeight2Width(v:UIView, o:CGFloat = 0.0, m:CGFloat = 1.0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.heightAnchor.constraint(equalTo: v.widthAnchor, multiplier: m, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    //MARK: position
    
    @discardableResult
    public func pinCenter(v:UIView, p:UILayoutPriority = 999) -> (NSLayoutConstraint, NSLayoutConstraint) {
        return (pinX(v: v, p: p), pinY(v: v, p: p))
    }
    
    @discardableResult
    public func pinX(v:UIView, o:CGFloat = 0.0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.centerXAnchor.constraint(equalTo: v.centerXAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinY(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.centerYAnchor.constraint(equalTo: v.centerYAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    //MARK: top
    
    @discardableResult
    public func pinTop(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.topAnchor.constraint(equalTo: v.topAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinTop2Bottom(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.topAnchor.constraint(equalTo: v.bottomAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    //MARK: bottom
    
    @discardableResult
    public func pinBottom(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinBottom2Top(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.bottomAnchor.constraint(equalTo: v.topAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    //MARK: left
    
    @discardableResult
    public func pinLeft(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.leftAnchor.constraint(equalTo: v.leftAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinLeft2Right(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.leftAnchor.constraint(equalTo: v.rightAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    //MARK: right
    
    @discardableResult
    public func pinRight(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.rightAnchor.constraint(equalTo: v.rightAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
    
    @discardableResult
    public func pinRight2Left(v:UIView, o:CGFloat = 0, a:Bool = true, p:UILayoutPriority = 999) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let c = self.rightAnchor.constraint(equalTo: v.leftAnchor, constant: o)
        
        c.priority = p
        c.isActive = a
        
        return c
    }
}
