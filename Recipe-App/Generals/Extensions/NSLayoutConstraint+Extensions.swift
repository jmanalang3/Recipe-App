//
//  NSLayoutConstraint+Extensions.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

extension NSLayoutConstraint {
    
    static func activate(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            $0.isActive = true
        }
    }
    
    static func pin(view: UIView, toEdgesOf anotherView: UIView) {
        activate([
            view.topAnchor.constraint(equalTo: anotherView.topAnchor),
            view.leftAnchor.constraint(equalTo: anotherView.leftAnchor),
            view.rightAnchor.constraint(equalTo: anotherView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor)
        ])
    }
}
