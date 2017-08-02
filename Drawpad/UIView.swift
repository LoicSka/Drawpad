//
//  UIView.swift
//  Drawpad
//
//  Created by Loic on 8/1/17.
//  Copyright © 2017 3sparks. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillParentView(padLeft: CGFloat, padRight: CGFloat, padTop: CGFloat, padBottom: CGFloat ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: padLeft).isActive = true
        self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: padRight).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: padBottom).isActive = true
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: padTop).isActive = true
        
    }
    
}

