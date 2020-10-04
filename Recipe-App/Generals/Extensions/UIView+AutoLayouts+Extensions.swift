//
//  UIView+AutoLayouts+Extensions.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

extension UIView {
    
    func fillSuperview() {
        guard let superview = superview
            else {
                return
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            topAnchor.constraint(equalTo: superview.topAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        ]
        constraints.forEach {
            $0.priority = UILayoutPriority(999)
            $0.isActive = true
        }
    }
    
    @discardableResult
    func addSubviewAndFill(_ subview: UIView, inset: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            subview.topAnchor.constraint(equalTo: topAnchor, constant: inset.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: inset.bottom),
            rightAnchor.constraint(equalTo: subview.rightAnchor, constant: inset.right)
        ]
        constraints.forEach {
            $0.isActive = true
        }
        return constraints
    }
    
    @discardableResult
    func addSubviewCenterXY(_ subview: UIView, width: CGFloat? = nil, height: CGFloat? = nil) -> [NSLayoutConstraint] {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        if let rawWidth = width, let rawHeight = height {
            let rawConstraints = [
                subview.widthAnchor.constraint(equalToConstant: rawWidth),
                subview.heightAnchor.constraint(equalToConstant: rawHeight),
            ]
            constraints.append(contentsOf: rawConstraints)
        }
        constraints.forEach {
            $0.isActive = true
        }
        return constraints
    }
    
}


