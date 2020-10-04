//
//  CardView.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

@IBDesignable
final class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 14
    @IBInspectable var shadowOffsetWidth: CGFloat = 0.2
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        styleViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
        styleViews()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureViews()
        styleViews()
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}

// MARK: -
// MARK: Setup View

fileprivate extension CardView {
    
    func configureViews() {}
    
    func styleViews() {}
    
}


