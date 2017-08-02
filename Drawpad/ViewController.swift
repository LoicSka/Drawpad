//
//  ViewController.swift
//  Drawpad
//
//  Created by Loic on 8/1/17.
//  Copyright © 2017 3sparks. All rights reserved.
//

import UIKit

protocol Paintable {
    
    var paintColor: CGColor { get set }
    mutating func setPaintingColor(_ color: CGColor)
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, Paintable {
    
    
    let colors: [UIColor] = [
        .amethyst,
        .paleOrange,
        .emerald,
        .houndGrey,
        .alizarin,
        .midnightBlue,
        .lavenderPink,
        .clearBlue
        ]
    
    
    fileprivate lazy var mainImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate lazy var tempImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var lastPoint = CGPoint.zero
    var paintColor: CGColor = UIColor.black.cgColor
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    
    // color palette collectionview
    
    lazy var paletteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)

        cv.collectionViewLayout = layout
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.clipsToBounds = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func setPaintingColor(_ color: CGColor) {
        paintColor = color
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String.random()
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ColorCollectionViewCell
        cell.color = colors[indexPath.item]
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setPaintingColor(colors[indexPath.item].cgColor)
    }
    
    
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))

        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(CGLineCap.square)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(paintColor)
        context?.setBlendMode(.normal)
        context?.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tempImageView.image = nil
    }
    
    
    func setupViews() {
        
        view.addSubview(tempImageView)
        view.addSubview(mainImageView)
        view.addSubview(paletteCollectionView)
        view.backgroundColor = .white
        
        tempImageView.fillParentView(padLeft: 0, padRight: 0, padTop: 0, padBottom: 0)
        mainImageView.fillParentView(padLeft: 0, padRight: 0, padTop: 0, padBottom: 0)
        
        paletteCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        paletteCollectionView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        paletteCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        paletteCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(colors.count * 60)).isActive = true
        
    }

}

