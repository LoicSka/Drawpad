//
//  BaseCollectionViewCell.swift
//  Drawpad
//
//  Created by Loic on 8/1/17.
//  Copyright © 2017 3sparks. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}
