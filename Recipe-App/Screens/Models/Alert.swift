//
//  Alert.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 04/10/2020.
//

import UIKit

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
