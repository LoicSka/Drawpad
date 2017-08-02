//
//  ColorCollectionViewCell.swift
//  Drawpad
//
//  Created by Loic on 8/1/17.
//  Copyright © 2017 3sparks. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: BaseCollectionViewCell {
    
    var color: UIColor? {
        didSet {
            paletteView.backgroundColor = color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            paletteView.layer.shadowOffset = CGSize.zero;
            paletteView.layer.shadowRadius = 3.0;
            paletteView.layer.shadowOpacity = 0.5;
        }
    }
    
    fileprivate lazy var paletteView = UIView().then {
        $0.layer.masksToBounds = false;
        $0.clipsToBounds = false;
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = 25
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func handleTap() {
        addPulse()
    }
    
    func addPulse() {
        
        let pulse = Pulsing(numberOfPulses: 1, radius: 90, position: paletteView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = color?.cgColor ?? UIColor(colorLiteralRed: 27/255, green: 111/255, blue: 247/255, alpha: 1).cgColor
        self.layer.insertSublayer(pulse, below: paletteView.layer)
    }
    
    override func setupViews() {
        addSubview(paletteView)
        
        // paletteView constraints
        paletteView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        paletteView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        paletteView.widthAnchor.constraint(equalToConstant: frame.width - 10).isActive = true
        paletteView.heightAnchor.constraint(equalToConstant: frame.width - 10).isActive = true
        
        paletteView.layer.cornerRadius = (frame.width - 10)/2
        
    }
    
}
