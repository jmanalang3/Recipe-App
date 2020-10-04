//
//  UITableViewCell+Extensions.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

extension UITableViewCell {
    
    func show(message: String) {
        backgroundColor = .clear
        isUserInteractionEnabled = false
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .center
        textLabel?.text = message
    }
    
}
